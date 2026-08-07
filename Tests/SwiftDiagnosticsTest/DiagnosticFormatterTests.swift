//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

final class DiagnosticFormatterTests: XCTestCase {
  func testFormattedMessage() {
    let message = SimpleDiagnosticMessage(
      message: "something went wrong",
      diagnosticID: MessageID(domain: "swift-syntax", id: "testing"),
      severity: .error,
      category: DiagnosticCategory(
        name: "Testing",
        documentationURL: "http://example.com"
      )
    )

    let formattedText = DiagnosticsFormatter().formattedMessage(message)
    XCTAssertEqual(formattedText, "error: something went wrong [#Testing]")
  }

  /// A highlight is rendered even when it covers a line other than the one that
  /// the diagnostic itself is located on.
  func testHighlightOnLineWithoutADiagnostic() throws {
    let source = """
      @available(*, unavailable)
      func f() { }
      """

    let tree = Parser.parse(source: source)
    let function = try XCTUnwrap(tree.statements.first?.item.as(FunctionDeclSyntax.self))
    let attribute = try XCTUnwrap(function.attributes.first?.as(AttributeSyntax.self))

    let diagnostic = Diagnostic(
      node: Syntax(function.name),
      message: SimpleDiagnosticMessage(
        message: "'f()' has been explicitly marked unavailable here",
        diagnosticID: MessageID(domain: "test", id: "unavailable"),
        severity: .note
      ),
      highlights: [Syntax(attribute)]
    )

    let expectedOutput = """
      \u{001B}[0;36m1 |\u{001B}[0;0m \u{001B}[4;39m@available(*, unavailable)\u{001B}[0;0m
      \u{001B}[0;36m2 |\u{001B}[0;0m func f() { }
        \u{001B}[0;36m|\u{001B}[0;0m      `- \u{001B}[1;39mnote: \u{001B}[1;39m'f()' has been explicitly marked unavailable here\u{001B}[0;0m

      """

    assertStringsEqualWithDiff(
      DiagnosticsFormatter.annotatedSource(tree: tree, diags: [diagnostic], colorize: true),
      expectedOutput
    )
  }

  /// A highlight that spans multiple lines is clamped to each line it covers,
  /// including lines that carry no diagnostic of their own and lines that end
  /// in a multi-byte character without a trailing newline.
  func testMultiLineHighlightEndingInEmoji() throws {
    let source = "func f() {\n  let x = 1 // 👨‍👩‍👧‍👦\n  let y = 2 // 🐮"

    let tree = Parser.parse(source: source)
    let function = try XCTUnwrap(tree.statements.first?.item.as(FunctionDeclSyntax.self))

    let diagnostic = Diagnostic(
      node: Syntax(function.name),
      message: SimpleDiagnosticMessage(
        message: "spanning highlight",
        diagnosticID: MessageID(domain: "test", id: "spanning"),
        severity: .error
      ),
      highlights: [Syntax(tree)]
    )

    let expectedOutput = """
      \u{001B}[0;36m1 |\u{001B}[0;0m \u{001B}[4;39mfunc f() {\u{001B}[0;0m
        \u{001B}[0;36m|\u{001B}[0;0m      `- \u{001B}[1;31merror: \u{001B}[1;39mspanning highlight\u{001B}[0;0m
      \u{001B}[0;36m2 |\u{001B}[0;0m \u{001B}[4;39m  let x = 1 // 👨‍👩‍👧‍👦\u{001B}[0;0m
      \u{001B}[0;36m3 |\u{001B}[0;0m \u{001B}[4;39m  let y = 2 // 🐮\u{001B}[0;0m

      """

    assertStringsEqualWithDiff(
      DiagnosticsFormatter.annotatedSource(tree: tree, diags: [diagnostic], colorize: true),
      expectedOutput
    )
  }
}
