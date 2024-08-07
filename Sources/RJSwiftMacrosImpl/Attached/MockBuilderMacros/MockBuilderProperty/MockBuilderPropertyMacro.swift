//
//  MockBuilderItemMacro.swift
//
//
//  Created by Rezo Joglidze on 03.08.24.
//

import SwiftSyntax
import SwiftSyntaxMacros
import RJSwiftCommon

// MARK: - Mock Builder Item Macro
public struct MockBuilderPropertyMacro: PeerMacro {
    // MARK: Methods
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        getItemSupportedType(from: node)
        return []
    }
    
    private static func getItemSupportedType(from node: SwiftSyntax.AttributeSyntax) -> MockBuilderSupportedType? {
        guard let argumentTuple = node.arguments?.as(LabeledExprListSyntax.self) else {
            return nil
        }
//        
//        guard let dataTypeElement = argumentTuple.first(where: { $0.label?.text == Constants.mockBuilderTypeParamIdentifier.rawValue }),
//              let argumentValue = dataTypeElement.expression.as(MemberAccessExprSyntax.self)?.declName.baseName,
//              let itemSupportedType = MockBuilderSupportedType(rawValue: argumentValue.text) else {
//            return nil
//        }
        
        return nil
    }
}
