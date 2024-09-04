//
//  Common.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftDiagnostics

// MARK: - Common Elements
func attributesElement(
    withIdentifier macroName: String,
    in attributes: AttributeListSyntax?
) -> AttributeListSyntax.Element? {
    attributes?.first {
        $0.as(AttributeSyntax.self)?
            .attributeName
            .as(IdentifierTypeSyntax.self)?
            .description == macroName
    }
}

func customKey(in attributesElement: AttributeListSyntax.Element) -> ExprSyntax? {
    attributesElement
        .as(AttributeSyntax.self)?
        .arguments?
        .as(LabeledExprListSyntax.self)?
        .first?
        .expression
}

// MARK: - Coding Keys Diagnostic
struct CodingKeysDiagnostic: DiagnosticMessage {
    let message: String = "Empty argument"
    let diagnosticID: SwiftDiagnostics.MessageID = .init(domain: "CodingKeysGeneration", id: "emptyArgument")
    let severity: SwiftDiagnostics.DiagnosticSeverity = .error
}
