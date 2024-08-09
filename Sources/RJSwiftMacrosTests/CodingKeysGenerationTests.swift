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
    // MARK: Properties
    let testMacros: [String : Macro.Type] = [
        "CodingKeys" : CodingKeysMacro.self
    ]
    
    // MARK: Test Coding KeysMacro For Struct With Snake Case Type
    func testCodingKeysMacro_for_struct_with_snake_case() throws {
        assertMacroExpansion(
           #"""
           @CodingKeys(codingKeyType: .snakeCase)
           struct University {
               let name: String
               let studentCapacity: Int
               
               static var students: [String] = []
               
               var oldName: String {
                   "Tbilisi"
               }
               
               init(name: String, studentCapacity: Int) {
                   self.name = name
                   self.studentCapacity = studentCapacity
               }
           }
           """#,
           expandedSource:
           #"""
           struct University {
               let name: String
               let studentCapacity: Int
               
               static var students: [String] = []
               
               var oldName: String {
                   "Tbilisi"
               }
               
               init(name: String, studentCapacity: Int) {
                   self.name = name
                   self.studentCapacity = studentCapacity
               }
           
               enum CodingKeys: String, CodingKey {
                   case name = "name"
                   case studentCapacity = "student_capacity"
               }
           }
           """#,
           macros: testMacros
        )
    }
    
    // MARK: Test Coding KeysMacro For Class With Snake Case Type
    func testCodingKeysMacro_for_class_with_camel_case() throws {
        assertMacroExpansion(
           #"""
           @CodingKeys(codingKeyType: .camelCase)
           class University {
               let name: String
               let studentCapacity: Int
               
               static var students: [String] = []
               
               var oldName: String {
                   "Tbilisi"
               }
               
               init(name: String, studentCapacity: Int) {
                   self.name = name
                   self.studentCapacity = studentCapacity
               }
           }
           """#,
           expandedSource:
           #"""
           class University {
               let name: String
               let studentCapacity: Int
               
               static var students: [String] = []
               
               var oldName: String {
                   "Tbilisi"
               }
               
               init(name: String, studentCapacity: Int) {
                   self.name = name
                   self.studentCapacity = studentCapacity
               }
           
               enum CodingKeys: String, CodingKey {
                   case name
                   case studentCapacity
               }
           }
           """#,
           macros: testMacros
        )
    }
    
    // MARK: Test Coding Key Property Macro
    func testCodingKeyPropertyMacro() throws {
        assertMacroExpansion(
           #"""
           @CodingKeys(codingKeyType: .camelCase)
           struct Person {
               let name: String
               @CodingKeyProperty("second_name") let surname: String
           }
           """#,
           expandedSource:
           #"""
           struct Person {
               let name: String
               @CodingKeyProperty("second_name") let surname: String
           
               enum CodingKeys: String, CodingKey {
                   case name
                   case surname = "second_name"
               }
           }
           """#,
           macros: testMacros
        )
    }
    
    // MARK: Test Coding Keys Ignored Macro
    func testCodingKeyIgnoredMacro() throws {
        assertMacroExpansion(
           #"""
           @CodingKeys(codingKeyType: .camelCase)
           struct Person {
               @CodingKeyIgnored() let name: String
               let surname: String
           }
           """#,
           expandedSource:
           #"""
           struct Person {
               @CodingKeyIgnored() let name: String
               let surname: String
           
               enum CodingKeys: String, CodingKey {
                   case surname
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
