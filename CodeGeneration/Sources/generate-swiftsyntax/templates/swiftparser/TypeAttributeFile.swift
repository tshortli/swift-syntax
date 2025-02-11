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

let typeAttributeFile = SourceFileSyntax {
  DeclSyntax(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  try! ExtensionDeclSyntax("extension Parser") {
    try EnumDeclSyntax("enum TypeAttribute: RawTokenKindSubset") {
      for attribute in TYPE_ATTR_KINDS {
        DeclSyntax("case \(raw: attribute.name)")
      }

      try InitializerDeclSyntax("init?(lexeme: Lexer.Lexeme)") {
        SwitchStmtSyntax(switchKeyword: .keyword(.switch), expression: ExprSyntax("lexeme")) {
          for attribute in TYPE_ATTR_KINDS {
            SwitchCaseSyntax("case RawTokenKindMatch(.\(raw: attribute.name)):") {
              ExprSyntax("self = .\(raw: attribute.swiftName)")
            }
          }
          SwitchCaseSyntax("default:") {
            StmtSyntax("return nil")
          }
        }
      }

      try VariableDeclSyntax("var rawTokenKind: RawTokenKind") {
        SwitchStmtSyntax(switchKeyword: .keyword(.switch), expression: ExprSyntax("self")) {
          for attribute in TYPE_ATTR_KINDS {
            SwitchCaseSyntax("case .\(raw: attribute.swiftName):") {
              StmtSyntax("return .keyword(.\(raw: attribute.name))")
            }
          }
        }
      }
    }
  }
}
