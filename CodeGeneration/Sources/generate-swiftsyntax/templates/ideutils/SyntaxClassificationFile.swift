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

// Collects the list of classifications to use for contextual classification.
fileprivate var node_child_classifications: [ChildClassification] {
  var result = [ChildClassification]()
  for node in SYNTAX_NODES {
    for (index, child) in node.children.enumerated() where child.classification?.name != nil {
      result.append(
        ChildClassification(node: node, childIndex: index, child: child)
      )
    }
  }
  
  return result
}

let syntaxClassificationFile = SourceFileSyntax {
  DeclSyntax("""
    \(raw: generateCopyrightHeader(for: "generate-ideutils"))
    @_spi(RawSyntax) import SwiftSyntax
    """)
  
  try! EnumDeclSyntax("public enum SyntaxClassification") {
    for classification in SYNTAX_CLASSIFICATIONS {
      DeclSyntax("""
        /// \(raw: classification.description)
        case \(raw: classification.swiftName)
        """)
    }
  }
  
  try! ExtensionDeclSyntax("extension SyntaxClassification") {
    try FunctionDeclSyntax(
        """
        /// Checks if a node has a classification attached via its syntax definition.
        /// - Parameters:
        ///   - parentKind: The parent node syntax kind.
        ///   - indexInParent: The index of the node in its parent.
        ///   - childKind: The node syntax kind.
        /// - Returns: A pair of classification and whether it is "forced", or nil if
        ///   no classification is attached.
        internal static func classify(
            parentKind: SyntaxKind, indexInParent: Int, childKind: SyntaxKind
          ) -> (SyntaxClassification, Bool)?
        """) {
          try IfStmtSyntax("""
            // Separate checks for token nodes (most common checks) versus checks for layout nodes.
            if childKind == .token
            """) {
            try SwitchStmtSyntax("switch (parentKind, indexInParent)") {
              for childClassification in node_child_classifications where childClassification.isToken {
                SwitchCaseSyntax("case (.\(raw: childClassification.parent.swiftSyntaxKind), \(raw: childClassification.childIndex)):") {
                  StmtSyntax("return (.\(raw: childClassification.classification!.swiftName), \(raw: childClassification.force))")
                }
              }
              
              SwitchCaseSyntax("default: return nil")
            }
          } else: {
            try SwitchStmtSyntax("switch (parentKind, indexInParent)") {
              for childClassification in node_child_classifications where !childClassification.isToken {
                SwitchCaseSyntax("case (.\(raw: childClassification.parent.swiftSyntaxKind), \(raw: childClassification.childIndex)):") {
                  StmtSyntax("return (.\(raw: childClassification.classification!.swiftName), \(raw: childClassification.force))")
                }
              }
              
              SwitchCaseSyntax("default: return nil")
            }
          }
        }
  }
  
  try! ExtensionDeclSyntax("extension RawTokenKind") {
    try VariableDeclSyntax("internal var classification: SyntaxClassification") {
        try SwitchStmtSyntax("switch self.base") {
          for token in SYNTAX_TOKENS {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              if let classification = token.classification {
                StmtSyntax("return .\(raw: classification.swiftName)")
              } else {
                StmtSyntax("return .none)")
              }
            }
          }
          SwitchCaseSyntax("case .eof:") {
            StmtSyntax("return .none")
          }
        }
      }
  }
}
