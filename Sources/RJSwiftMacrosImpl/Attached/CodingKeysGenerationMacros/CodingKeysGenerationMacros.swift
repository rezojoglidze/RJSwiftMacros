//
//  CodingKeysGenerationMacros.swift
//
//
//  Created by Rezo Joglidze on 14.07.24.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

// MARK: - Coding Keys Macro
public struct CodingKeysMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let cases: [String] = try declaration.memberBlock.members.compactMap { member in
            guard let variableDecl = member.decl.as(VariableDeclSyntax.self),
                  let property = variableDecl.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else { return nil }
            
            if attributesElement(withIdentifier: "CodingKeyIgnored", in: variableDecl.attributes) != nil {
                return nil
            } else if let element = attributesElement(withIdentifier: "CodingKeyProperty", in: variableDecl.attributes) {
                guard let customKeyName = customKey(in: element) else {
                    let diagnostic = Diagnostic(node: Syntax(node), message: CodingKeysDiagnostic())
                    throw DiagnosticsError(diagnostics: [diagnostic])
                }
                return "case \(property) = \(customKeyName)"
            } else {
                let raw = property.dropBackticks()
                let snakeCase = raw.snakeCased()
                return raw == snakeCase ? "case \(property)" : "case \(property) = \"\(snakeCase)\""
            }
        }
        guard !cases.isEmpty else { return [] }
        let casesDecl: DeclSyntax = """
enum CodingKeys: String, CodingKey {
    \(raw: cases.joined(separator: "\n    "))
}
"""
        return [casesDecl]
    }
}
