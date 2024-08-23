//
//  MockBuilderTests.swift
//
//
//  Created by Rezo Joglidze on 28.07.24.
//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

#if canImport(RJSwiftMacrosImpl)
@testable import RJSwiftMacrosImpl

// MARK: Mock Builder Tests For Debuging. I couldn't write test cases because each variable generates randomly
final class MockBuilderTests: XCTestCase {
    // MARK: Properties
    let testMacros: [String : Macro.Type] = [
        "MockBuilder" : MockBuilderMacro.self
    ]

    func test_func_for_DEBUG() throws {
        assertMacroExpansion(
            #"""
            @MockBuilder(numberOfItems: 2)
            struct MockBuilderTest {
            
            }
            """#,
            expandedSource: "",
            macros: testMacros
        )
    }
}
#else
   #warning("macros are only supported when running tests for the host platform")
#endif
