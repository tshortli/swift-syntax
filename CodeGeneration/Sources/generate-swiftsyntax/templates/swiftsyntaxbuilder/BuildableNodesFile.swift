//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let buildableNodesFile = SourceFileSyntax {
  ImportDeclSyntax(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntaxbuilder")),
    path: [AccessPathComponentSyntax(name: "SwiftSyntax")]
  )

  for node in SYNTAX_NODES where node.isBuildable {
    let type = node.type

    if let convenienceInit = createConvenienceInitializer(node: node) {
      let docComment: SwiftSyntax.Trivia = node.documentation.isEmpty ? [] : .docLineComment("/// \(node.documentation)") + .newline
      ExtensionDeclSyntax(
        leadingTrivia: docComment,
        extendedType: SimpleTypeIdentifierSyntax(name: .identifier(type.syntaxBaseName))
      ) {
        convenienceInit
      }
    }
  }
}

private func convertFromSyntaxProtocolToSyntaxType(child: Child) -> ExprSyntax {
  if child.type.isBaseType && child.nodeChoices.isEmpty {
    return ExprSyntax("\(raw: child.type.syntaxBaseName)(fromProtocol: \(raw: child.swiftName))")
  } else {
    return ExprSyntax(IdentifierExprSyntax(identifier: .identifier(child.swiftName)))
  }
}

/// Create a builder-based convenience initializer, if needed.
private func createConvenienceInitializer(node: Node) -> InitializerDeclSyntax? {
  // Only create the convenience initializer if at least one parameter
  // is different than in the default initializer generated above.
  var shouldCreateInitializer = false

  // Keep track of init parameters and result builder parameters in different
  // lists to make sure result builder params occur at the end, so that
  // they can use trailing closure syntax.
  var normalParameters: [FunctionParameterSyntax] = []
  var builderParameters: [FunctionParameterSyntax] = []
  var delegatedInitArgs: [TupleExprElementSyntax] = []

  for child in node.children {
    /// The expression that is used to call the default initializer defined above.
    let produceExpr: ExprSyntax
    if child.type.isBuilderInitializable {
      // Allow initializing certain syntax collections with result builders
      shouldCreateInitializer = true
      let builderInitializableType = child.type.builderInitializableType
      if child.type.builderInitializableType != child.type {
        let param = Node.from(type: child.type).singleNonDefaultedChild
        if child.isOptional {
          produceExpr = ExprSyntax("\(raw: child.swiftName)Builder().map { \(raw: child.type.syntaxBaseName)(\(raw: param.swiftName): $0) }")
        } else {
          produceExpr = ExprSyntax("\(raw: child.type.syntaxBaseName)(\(raw: param.swiftName): \(raw: child.swiftName)Builder())")
        }
      } else {
        produceExpr = ExprSyntax("\(raw: child.swiftName)Builder()")
      }
      builderParameters.append(FunctionParameterSyntax(
        "@\(builderInitializableType.resultBuilderBaseName) \(child.swiftName)Builder: () throws-> \(builderInitializableType.syntax)",
        for: .functionParameters
      ))
    } else {
      produceExpr = convertFromSyntaxProtocolToSyntaxType(child: child)
      normalParameters.append(FunctionParameterSyntax(
        firstName: .identifier(child.swiftName),
        colon: .colonToken(),
        type: child.parameterType,
        defaultArgument: child.defaultInitialization.map { InitializerClauseSyntax(value: $0) }
      ))
    }
    delegatedInitArgs.append(TupleExprElementSyntax(label: child.isUnexpectedNodes ? nil : child.swiftName, expression: produceExpr))
  }

  guard shouldCreateInitializer else {
    return nil
  }

  return InitializerDeclSyntax(
    leadingTrivia: .docLineComment("/// A convenience initializer that allows initializing syntax collections using result builders") + .newline,
    modifiers: [DeclModifierSyntax(leadingTrivia: .newline, name: .keyword(.public))],
    signature: FunctionSignatureSyntax(
      input: ParameterClauseSyntax {
        FunctionParameterSyntax("leadingTrivia: Trivia? = nil", for: .functionParameters)
        for param in normalParameters + builderParameters {
          param
        }
        FunctionParameterSyntax("trailingTrivia: Trivia? = nil", for: .functionParameters)
      },
      effectSpecifiers: DeclEffectSpecifiersSyntax(throwsSpecifier: .keyword(.rethrows)))
  ) {
    FunctionCallExprSyntax(callee: ExprSyntax("try self.init")) {
      TupleExprElementSyntax(label: "leadingTrivia", expression: ExprSyntax("leadingTrivia"))
      for arg in delegatedInitArgs {
        arg
      }
      TupleExprElementSyntax(label: "trailingTrivia", expression: ExprSyntax("trailingTrivia"))
    }
  }
}

