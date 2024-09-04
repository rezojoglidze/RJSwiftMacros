//
//  MockBuilderItemMacro.swift
//
//
//  Created by Rezo Joglidze on 03.08.24.
//

import SwiftSyntax
import SwiftSyntaxMacros

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
        
        checkIfInitialValueIsNil(
            of: node,
            declaration: declaration,
            context: context
        )
        
        return []
    }
    
    private static func checkIfInitialValueIsNil(
        of node: SwiftSyntax.AttributeSyntax,
        declaration: some SwiftSyntax.DeclSyntaxProtocol,
        context: some SwiftSyntaxMacros.MacroExpansionContext
    ) {
        if let _ = node.arguments?.as(LabeledExprListSyntax.self)?.first(where: {
            $0.expression.is(NilLiteralExprSyntax.self)
        }) {
            MockBuilderDiagnostic.report(
                diagnostic: .mockBuilderPropertyNotSupoortsNil,
                node: Syntax(node),
                context: context)
        }
    }
    
    private static func checkIfMockBuilderPropertyIsSupported(
        of node: SwiftSyntax.AttributeSyntax,
        declaration: some SwiftSyntax.DeclSyntaxProtocol,
        context: some SwiftSyntaxMacros.MacroExpansionContext
    ) {
        guard let variableDecl = declaration.as(VariableDeclSyntax.self) else { return }
        
        var mockSupportedTypeString: String {
            if let variableType = variableDecl.variableType?.as(IdentifierTypeSyntax.self)?.name.text {
                return variableType
            } else if let wrappedType = variableDecl.variableType?.as(OptionalTypeSyntax.self)?.wrappedType,
                      let variableTypeString = wrappedType.as(IdentifierTypeSyntax.self)?.name.text {
                
                return  variableTypeString
            }
            
            return .empty
        }
                
        if let mockSupportedType = MockBuilderSupportedType(rawValue: mockSupportedTypeString),
           MockBuilderSupportedType.notSupportedFromMockBuilderPropertyMacro(type: mockSupportedType) {
            MockBuilderDiagnostic.report(
                diagnostic: .mockBuilderPropertyNotSupported(mockSupportedType.rawValue),
                node: Syntax(node),
                context: context)
        }
    }
}
