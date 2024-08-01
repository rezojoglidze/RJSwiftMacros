//
//  CodingKeyIgnoredMacro.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//

import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Coding Key Ignored Macro
public struct CodingKeyIgnoredMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}
