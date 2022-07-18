
//// Automatically Generated by SwiftSyntaxBuilderGeneration
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

import SwiftSyntax
public protocol DeclListBuildable: SyntaxListBuildable {
  /// Builds list of `DeclSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildDeclList(format: Format, leadingTrivia: Trivia?)-> [DeclSyntax]
}
public protocol DeclBuildable: ExpressibleAsDeclBuildable, DeclListBuildable, SyntaxBuildable {
  /// Builds list of `DeclSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildDecl(format: Format, leadingTrivia: Trivia?)-> DeclSyntax
}
public extension DeclBuildable {
  /// Satisfies conformance to `ExpressibleAsDeclBuildable`.
func createDeclBuildable()-> DeclBuildable {
    return self
  }
  /// Builds list of `DeclSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
///
/// Satisfies conformance to `DeclListBuildable`
func buildDeclList(format: Format, leadingTrivia: Trivia? = nil)-> [DeclSyntax] {
    return [buildDecl(format: format, leadingTrivia: leadingTrivia)]
  }
  /// Builds a `DeclSyntax`.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
/// - Returns: A new `Syntax` with the built `DeclSyntax`.
///
/// Satisfies conformance to `SyntaxBuildable`.
func buildSyntax(format: Format, leadingTrivia: Trivia? = nil)-> Syntax {
    return Syntax(buildDecl(format: format, leadingTrivia: leadingTrivia))
  }
}
public protocol ExprListBuildable: SyntaxListBuildable {
  /// Builds list of `ExprSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildExprList(format: Format, leadingTrivia: Trivia?)-> [ExprSyntax]
}
public protocol ExprBuildable: ExpressibleAsExprBuildable, ExprListBuildable, SyntaxBuildable {
  /// Builds list of `ExprSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildExpr(format: Format, leadingTrivia: Trivia?)-> ExprSyntax
}
public extension ExprBuildable {
  /// Satisfies conformance to `ExpressibleAsExprBuildable`.
func createExprBuildable()-> ExprBuildable {
    return self
  }
  /// Builds list of `ExprSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
///
/// Satisfies conformance to `ExprListBuildable`
func buildExprList(format: Format, leadingTrivia: Trivia? = nil)-> [ExprSyntax] {
    return [buildExpr(format: format, leadingTrivia: leadingTrivia)]
  }
  /// Builds a `ExprSyntax`.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
/// - Returns: A new `Syntax` with the built `ExprSyntax`.
///
/// Satisfies conformance to `SyntaxBuildable`.
func buildSyntax(format: Format, leadingTrivia: Trivia? = nil)-> Syntax {
    return Syntax(buildExpr(format: format, leadingTrivia: leadingTrivia))
  }
}
public protocol PatternListBuildable: SyntaxListBuildable {
  /// Builds list of `PatternSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildPatternList(format: Format, leadingTrivia: Trivia?)-> [PatternSyntax]
}
public protocol PatternBuildable: ExpressibleAsPatternBuildable, PatternListBuildable, SyntaxBuildable {
  /// Builds list of `PatternSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildPattern(format: Format, leadingTrivia: Trivia?)-> PatternSyntax
}
public extension PatternBuildable {
  /// Satisfies conformance to `ExpressibleAsPatternBuildable`.
func createPatternBuildable()-> PatternBuildable {
    return self
  }
  /// Builds list of `PatternSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
///
/// Satisfies conformance to `PatternListBuildable`
func buildPatternList(format: Format, leadingTrivia: Trivia? = nil)-> [PatternSyntax] {
    return [buildPattern(format: format, leadingTrivia: leadingTrivia)]
  }
  /// Builds a `PatternSyntax`.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
/// - Returns: A new `Syntax` with the built `PatternSyntax`.
///
/// Satisfies conformance to `SyntaxBuildable`.
func buildSyntax(format: Format, leadingTrivia: Trivia? = nil)-> Syntax {
    return Syntax(buildPattern(format: format, leadingTrivia: leadingTrivia))
  }
}
public protocol StmtListBuildable: SyntaxListBuildable {
  /// Builds list of `StmtSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildStmtList(format: Format, leadingTrivia: Trivia?)-> [StmtSyntax]
}
public protocol StmtBuildable: ExpressibleAsStmtBuildable, StmtListBuildable, SyntaxBuildable {
  /// Builds list of `StmtSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildStmt(format: Format, leadingTrivia: Trivia?)-> StmtSyntax
}
public extension StmtBuildable {
  /// Satisfies conformance to `ExpressibleAsStmtBuildable`.
func createStmtBuildable()-> StmtBuildable {
    return self
  }
  /// Builds list of `StmtSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
///
/// Satisfies conformance to `StmtListBuildable`
func buildStmtList(format: Format, leadingTrivia: Trivia? = nil)-> [StmtSyntax] {
    return [buildStmt(format: format, leadingTrivia: leadingTrivia)]
  }
  /// Builds a `StmtSyntax`.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
/// - Returns: A new `Syntax` with the built `StmtSyntax`.
///
/// Satisfies conformance to `SyntaxBuildable`.
func buildSyntax(format: Format, leadingTrivia: Trivia? = nil)-> Syntax {
    return Syntax(buildStmt(format: format, leadingTrivia: leadingTrivia))
  }
}
public protocol SyntaxListBuildable {
  /// Builds list of `Syntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildSyntaxList(format: Format, leadingTrivia: Trivia?)-> [Syntax]
}
public protocol SyntaxBuildable: ExpressibleAsSyntaxBuildable, SyntaxListBuildable {
  /// Builds list of `Syntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildSyntax(format: Format, leadingTrivia: Trivia?)-> Syntax
}
public extension SyntaxBuildable {
  /// Satisfies conformance to `ExpressibleAsSyntaxBuildable`.
func createSyntaxBuildable()-> SyntaxBuildable {
    return self
  }
  /// Builds list of `Syntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
///
/// Satisfies conformance to `SyntaxListBuildable`
func buildSyntaxList(format: Format, leadingTrivia: Trivia? = nil)-> [Syntax] {
    return [buildSyntax(format: format, leadingTrivia: leadingTrivia)]
  }
}
public protocol TypeListBuildable: SyntaxListBuildable {
  /// Builds list of `TypeSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildTypeList(format: Format, leadingTrivia: Trivia?)-> [TypeSyntax]
}
public protocol TypeBuildable: ExpressibleAsTypeBuildable, TypeListBuildable, SyntaxBuildable {
  /// Builds list of `TypeSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
func buildType(format: Format, leadingTrivia: Trivia?)-> TypeSyntax
}
public extension TypeBuildable {
  /// Satisfies conformance to `ExpressibleAsTypeBuildable`.
func createTypeBuildable()-> TypeBuildable {
    return self
  }
  /// Builds list of `TypeSyntax`s.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
///
/// Satisfies conformance to `TypeListBuildable`
func buildTypeList(format: Format, leadingTrivia: Trivia? = nil)-> [TypeSyntax] {
    return [buildType(format: format, leadingTrivia: leadingTrivia)]
  }
  /// Builds a `TypeSyntax`.
/// - Parameter format: The `Format` to use.
/// - Parameter leadingTrivia: Replaces the last leading trivia if not nil.
/// - Returns: A new `Syntax` with the built `TypeSyntax`.
///
/// Satisfies conformance to `SyntaxBuildable`.
func buildSyntax(format: Format, leadingTrivia: Trivia? = nil)-> Syntax {
    return Syntax(buildType(format: format, leadingTrivia: leadingTrivia))
  }
}