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

let declarationModifierFile = SourceFileSyntax {
  DeclSyntax(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  try! EnumDeclSyntax("enum DeclarationModifier: RawTokenKindSubset") {
    for attribute in DECL_MODIFIER_KINDS {
      DeclSyntax("case \(raw: attribute.swiftName)")
    }

    try InitializerDeclSyntax("init?(lexeme: Lexer.Lexeme)") {
      try SwitchStmtSyntax("switch lexeme") {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCaseSyntax("case RawTokenKindMatch(.\(raw: attribute.swiftName)):") {
            ExprSyntax("self = .\(raw: attribute.swiftName)")
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return nil")
        }
      }
    }
    
    try VariableDeclSyntax("var rawTokenKind: RawTokenKind") {
      try SwitchStmtSyntax("switch self") {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCaseSyntax("case .\(raw: attribute.swiftName):") {
            if attribute.swiftName.hasSuffix("Keyword") {
              StmtSyntax("return .\(raw: attribute.swiftName)")
            } else {
              StmtSyntax("return .keyword(.\(raw: attribute.swiftName))")
            }
          }
        }
      }
    }
  }
}
