//// Automatically Generated From CommonNodes.swift.gyb.
//// Do Not Edit Directly!
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

public let COMMON_NODES: [Node] = [
  Node(name: "Decl",
       nameForDiagnostics: "declaration",
       kind: "Syntax",
       parserFunction: "parseDeclaration"),

  Node(name: "Expr",
       nameForDiagnostics: "expression",
       kind: "Syntax",
       parserFunction: "parseExpression"),

  Node(name: "Stmt",
       nameForDiagnostics: "statement",
       kind: "Syntax",
       parserFunction: "parseStatement"),

  Node(name: "Type",
       nameForDiagnostics: "type",
       kind: "Syntax",
       parserFunction: "parseType"),

  Node(name: "Pattern",
       nameForDiagnostics: "pattern",
       kind: "Syntax",
       parserFunction: "parsePattern"),

  Node(name: "Missing",
       nameForDiagnostics: nil,
       kind: "Syntax"),

  Node(name: "MissingDecl",
       nameForDiagnostics: "declaration",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier")
       ]),

  Node(name: "MissingExpr",
       nameForDiagnostics: "expression",
       kind: "Expr"),

  Node(name: "MissingStmt",
       nameForDiagnostics: "statement",
       kind: "Stmt"),

  Node(name: "MissingType",
       nameForDiagnostics: "type",
       kind: "Type"),

  Node(name: "MissingPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern"),

  Node(name: "CodeBlockItem",
       nameForDiagnostics: nil,
       description: "A CodeBlockItem is any Syntax node that appears on its own line insidea CodeBlock.",
       kind: "Syntax",
       children: [
         Child(name: "Item",
               kind: "Syntax",
               description: "The underlying node inside the code block.",
               nodeChoices: [
                 Child(name: "Decl",
                       kind: "Decl"),
                 Child(name: "Stmt",
                       kind: "Stmt"),
                 Child(name: "Expr",
                       kind: "Expr")
               ]),
         Child(name: "Semicolon",
               kind: "SemicolonToken",
               description: "If present, the trailing semicolon at the end of the item.",
               isOptional: true,
               tokenChoices: [
                 "Semicolon"
               ])
       ],
       omitWhenEmpty: true),

  Node(name: "CodeBlockItemList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "CodeBlockItem",
       elementsSeparatedByNewline: true),

  Node(name: "CodeBlock",
       nameForDiagnostics: "code block",
       kind: "Syntax",
       traits: [
         "Braced",
         "WithStatements"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken",
               tokenChoices: [
                 "LeftBrace"
               ]),
         Child(name: "Statements",
               kind: "CodeBlockItemList",
               collectionElementName: "Statement",
               isIndented: true),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               tokenChoices: [
                 "RightBrace"
               ],
               requiresLeadingNewline: true)
       ]),

  Node(name: "DeclEffectSpecifiers",
       nameForDiagnostics: "effect specifiers",
       kind: "Syntax",
       traits: [
         "EffectSpecifiers"
       ],
       children: [
         Child(name: "AsyncSpecifier",
               kind: "KeywordToken",
               isOptional: true,
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "async",
                 "reasync"
               ]),
         Child(name: "ThrowsSpecifier",
               kind: "KeywordToken",
               isOptional: true,
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "throws",
                 "rethrows"
               ])
       ]),

  Node(name: "TypeEffectSpecifiers",
       nameForDiagnostics: "effect specifiers",
       kind: "Syntax",
       traits: [
         "EffectSpecifiers"
       ],
       children: [
         Child(name: "AsyncSpecifier",
               kind: "KeywordToken",
               isOptional: true,
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "async"
               ]),
         Child(name: "ThrowsSpecifier",
               kind: "KeywordToken",
               isOptional: true,
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "throws"
               ])
       ]),

  Node(name: "UnexpectedNodes",
       nameForDiagnostics: nil,
       description: "A collection of syntax nodes that occurred in the source code butcould not be used to form a valid syntax tree.",
       kind: "SyntaxCollection",
       element: "Syntax"),

]
