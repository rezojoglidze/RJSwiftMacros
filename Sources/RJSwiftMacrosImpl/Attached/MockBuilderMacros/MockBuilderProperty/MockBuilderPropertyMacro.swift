//
//  MockBuilderItemMacro.swift
//
//
//  Created by Rezo Joglidze on 03.08.24.
//

import SwiftSyntax
import SwiftSyntaxMacros
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

// MARK: - Mock Builder Item Macro
public struct MockBuilderPropertyMacro: PeerMacro {
    // MARK: Methods
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        checkIfMockBuilderPropertyIsSupported(
            of: node,
            declaration: declaration,
            context: context
        )
        
        return []
    }
    
    private static func checkIfMockBuilderPropertyIsSupported(
        of node: SwiftSyntax.AttributeSyntax,
        declaration: some SwiftSyntax.DeclSyntaxProtocol,
        context: some SwiftSyntaxMacros.MacroExpansionContext
    ) {
        if let variableDecl = declaration.as(VariableDeclSyntax.self),
           let variableType = variableDecl.variableType?.as(IdentifierTypeSyntax.self)?.name.text,
           let mockSupportedType = MockBuilderSupportedType(rawValue: variableType) {
            
            if MockBuilderSupportedType.notSupportedFromMockBuilderPropertyMacro(type: mockSupportedType) {
                MockBuilderDiagnostic.report(
                    diagnostic: .mockBuilderPropertyNotSupported(mockSupportedType.rawValue),
                    node: Syntax(node),
                    context: context)
            }
        }
    }
}
