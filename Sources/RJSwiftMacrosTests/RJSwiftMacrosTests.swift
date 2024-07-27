//
//  RJSwiftMacrosTests.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import RJSwiftMacrosImpl

let testMacros: [String : Macro.Type] = [
    "CodingKeys" : CodingKeysMacro.self
]

// MARK: - Swift Macros Tests
final class RJSwiftMacrosTests: XCTestCase {
    
    // test CodingKeys Macro
    func testCodingKeysMacro() throws {
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
