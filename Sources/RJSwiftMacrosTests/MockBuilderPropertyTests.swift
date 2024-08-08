//
//  MockBuilderPropertyTests.swift
//  
//
//  Created by Rezo Joglidze on 05.08.24.
//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(RJSwiftMacrosImpl)
@testable import RJSwiftMacrosImpl

// MARK: Mock Builder Item Tests
final class MockBuilderPropertyTests: XCTestCase {
    // MARK: Properties
    let testMacros: [String : Macro.Type] = [
        "MockBuilder" : MockBuilderMacro.self,
        "MockBuilderProperty": MockBuilderPropertyMacro.self
    ]
    
    // MARK: Tests
    func testMockBuilderMacro_for_class() throws {
        assertMacroExpansion(
            #"""
            @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
            class Person {
                @MockBuilderProperty(value: "RezoMock") let surname: String
                let name: String

                init(surname: String,
                     name: String) {
                    self.surname = surname
                   self.name = name
                }
            }
            """#,
            expandedSource: """
            class Car {
                let color: String
                let model: String
            }
            """,
            macros: testMacros
        )
    }
}

#endif
