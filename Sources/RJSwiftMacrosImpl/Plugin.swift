//
//  Plugin.swift
//  
//
//  Created by Rezo Joglidze on 16.07.24.
//

//#if canImport(SwiftCompilerPlugin)
    import SwiftCompilerPlugin
    import SwiftSyntaxMacros
    
    // MARK: - Plugin
    @main
    struct Plugin: CompilerPlugin {
        let providingMacros: [Macro.Type] = [
            // MARK: Attached Macros
            
            // CodingKeys Macros
            CodingKeysMacro.self,
            CodingKeyPropertyMacro.self,
            CodingKeyIgnoredMacro.self,
            
            // Mock Builder Macro
            MockBuilderMacro.self
        ]
    }
//#endif
