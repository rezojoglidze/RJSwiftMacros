//
//  Plugin.swift
//  
//
//  Created by Rezo Joglidze on 16.07.24.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

// MARK: - Plugin
@main
struct Plugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CodingKeysMacro.self,
        CodingKeyPropertyMacro.self,
        CodingKeyIgnoredMacro.self
    ]
}
