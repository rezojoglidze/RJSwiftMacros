//
//  File.swift
//  
//
//  Created by Rezo Joglidze on 28.07.24.
//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(RJSwiftMacrosImpl)
@testable import RJSwiftMacrosImpl

// MARK: Mock Builder Tests
final class MockBuilderTests: XCTestCase {
    // MARK: Properties
    let testMacros: [String : Macro.Type] = [
        "MockBuilder" : MockBuilderMacro.self
    ]
    
    // MARK: Tests
    func testMockBuilderMacro_for_class() throws {
        assertMacroExpansion(
            #"""
            @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
            class Car {
                let color: String
                let model: String
                
                init(color: String, model: String) {
                    self.color = color
                    self.model = model
                }
            }
            """#,
            expandedSource: """
            class Car {
                let color: String
                let model: String
                
                init(color: String, model: String) {
                    self.color = color
                    self.model = model
                }

                #if DEBUG
                static var mock: Car {
                    .init(
                        color: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                        model: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                        )
                }

                static var mockArray: [Car ] {
                    [
                        .init(
                            color: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                            model: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                            ),
                        .init(
                            color: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                            model: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                            ),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
    }
    
    
    func testMockBuilderMacro_for_struct() throws {
        assertMacroExpansion(
        #"""
        @MockBuilder(numberOfItems: 3, dataGeneratorType: .random)
        struct Person {
            let name: String
            let surname: String
        }
        """#,
        expandedSource: """
        struct Person {
            let name: String
            let surname: String

            #if DEBUG
            static var mock: Person {
                .init(
                    name: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                    surname: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                    )
            }

            static var mockArray: [Person ] {
                [
                    .init(
                        name: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                        surname: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                        ),
                    .init(
                        name: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                        surname: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                        ),
                    .init(
                        name: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                        surname: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                        ),
                ]
            }
            #endif
        }
        """,
        macros: testMacros
        )
    }
    
    // TODO: fix it, .motorcycle return isnot correct
//    func testMockBuilderMacro_for_enum() throws {
//        assertMacroExpansion(
//            #"""
//            @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
//            enum VehicleType {
//               case car
//               case bus
//               case motorcycle
//            }
//            """#,
//            expandedSource: """
//            enum VehicleType {
//               case car
//               case bus
//               case motorcycle
//
//                #if DEBUG
//                static var mock: VehicleType {
//                    .motorcycle
//                }
//
//                static var mockArray: [VehicleType ] {
//                    [
//                        .car,
//                        .bus,
//                    ]
//                }
//                #endif
//            }
//            """,
//            macros: testMacros
//            )
//    }
    
    func testMockBuilderMacro_for_class_which_has_custom_type_property() throws {
        assertMacroExpansion(
            #"""
            @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
            struct Person {
               let name: String
            }
            
            @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
            class Car {
                let color: String
                let owner: Person
                
                init(color: String, owner: Person) {
                    self.color = color
                    self.owner = owner
                }
            }
            """#,
            expandedSource: """
            struct Person {
               let name: String

                #if DEBUG
                static var mock: Person {
                    .init(
                        name: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                        )
                }

                static var mockArray: [Person ] {
                    [
                        .init(
                            name: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                            ),
                        .init(
                            name: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String
                            ),
                    ]
                }
                #endif
            }
            class Car {
                let color: String
                let owner: Person
                
                init(color: String, owner: Person) {
                    self.color = color
                    self.owner = owner
                }

                #if DEBUG
                static var mock: Car {
                    .init(
                        color: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                        owner: Person.mock
                        )
                }

                static var mockArray: [Car ] {
                    [
                        .init(
                            color: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                            owner: Person.mock
                            ),
                        .init(
                            color: MockBuilderSupportedType.generate(elementType: .string, generatorType: .random) as! String,
                            owner: Person.mock
                            ),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
    }
}
#else
   #warning("macros are only supported when running tests for the host platform")
#endif
