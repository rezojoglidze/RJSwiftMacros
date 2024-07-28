//
//  CodingKeysGenerationTests.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(RJSwiftMacrosImpl)
@testable import RJSwiftMacrosImpl

// MARK: - Coding Keys Generation Tests
final class CodingKeysGenerationTests: XCTestCase {
    // MARK: Test Properties
    let testMacros: [String : Macro.Type] = [
        "CodingKeys" : CodingKeysMacro.self
    ]
    
    // MARK: Tests
    func testCodingKeysMacros() throws {
        assertMacroExpansion(
            #"""
            @CodingKeys
            struct Car {
                let name: String
                @CodingKeyProperty("second_name") let surname: String
                @CodingKeyIgnored() let color: String
            }
            """#,
            expandedSource: #"""
            struct Car {
                let name: String
                @CodingKeyProperty("second_name") let surname: String
                @CodingKeyIgnored() let color: String
            
                enum CodingKeys: String, CodingKey {
                    case name
                    case surname = "second_name"
                }
            }
            """#,
            macros: testMacros
        )
    }
}
#else
   #warning("macros are only supported when running tests for the host platform")
#endif
