//
//  MockBuilderItemMacro.swift
//
//
//  Created by Rezo Joglidze on 03.08.24.
//

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Mock Builder Item Macro
public struct MockBuilderItemMacro: PeerMacro {
    // MARK: Methods
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        
        return []
    }
}
