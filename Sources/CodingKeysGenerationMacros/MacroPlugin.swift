//
//  File.swift
//  
//
//  Created by Rezo Joglidze on 14.07.24.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct CodingKeysGenerationPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CodingKeysMacro.self
    ]
}
