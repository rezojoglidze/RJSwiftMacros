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

    // MARK: Test MockBuilder Macro for struct. Struct includes all supporeted types variables.
    func testMockBuilderPropertyMacro_all_supported_cases_for_struct() throws {
        assertMacroExpansion(
            #"""
            @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
            struct ExampleAllSupportedTypes {
                let intVariable: Int
                let int8Variable: Int8
                let int16Variable: Int16
                let int32Variable: Int32
                let int64Variable: Int64
                let uintVariable: UInt
                let uint8Variable: UInt8
                let uint16Variable: UInt16
                let uint32Variable: UInt32
                let uint64Variable: UInt64
                let floatVariable: Float
                let float32Variable: Float32
                let float64Variable: Float64
                let doubleVariable: Double
                let stringVariable: String
                let boolVariable: Bool
                let dateVariable: Date
                let uuidVariable: UUID
                let objectIndetifierVariable: ObjectIdentifier
                let cgPointVariable: CGPoint
                let cgRectVariable: CGRect
                let cgSizeVariable: CGSize
                let cgVectorVariable: CGVector
                let cgFloatVariable: CGFloat
                let urlVariable: URL
                let imageVariable: Image
            }
            """#,
            expandedSource: """
            struct ExampleAllSupportedTypes {
                let intVariable: Int
                let int8Variable: Int8
                let int16Variable: Int16
                let int32Variable: Int32
                let int64Variable: Int64
                let uintVariable: UInt
                let uint8Variable: UInt8
                let uint16Variable: UInt16
                let uint32Variable: UInt32
                let uint64Variable: UInt64
                let floatVariable: Float
                let float32Variable: Float32
                let float64Variable: Float64
                let doubleVariable: Double
                let stringVariable: String
                let boolVariable: Bool
                let dateVariable: Date
                let uuidVariable: UUID
                let objectIndetifierVariable: ObjectIdentifier
                let cgPointVariable: CGPoint
                let cgRectVariable: CGRect
                let cgSizeVariable: CGSize
                let cgVectorVariable: CGVector
                let cgFloatVariable: CGFloat
                let urlVariable: URL
                let imageVariable: Image
            
                #if DEBUG
                static var mock: ExampleAllSupportedTypes {
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(), generatorType: .random) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(), generatorType: .random) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(), generatorType: .random) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(), generatorType: .random) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(), generatorType: .random) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(), generatorType: .random) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(), generatorType: .random) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(), generatorType: .random) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(), generatorType: .random) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(), generatorType: .random) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(), generatorType: .random) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(), generatorType: .random) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(), generatorType: .random) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(), generatorType: .random) as! Double,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(), generatorType: .random) as! Bool,
                        dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                        uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(), generatorType: .random) as! UUID,
                        objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                        cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                        cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                        cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                        cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                        cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                        urlVariable: MockBuilderSupportedType.generate(elementType: .url(), generatorType: .random) as! URL,
                        imageVariable: MockBuilderSupportedType.generate(elementType: .image, generatorType: .random) as! Image
                        )
                }
            
                static var mockArray: [ExampleAllSupportedTypes ] {
                    [
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(), generatorType: .random) as! URL,
                            imageVariable: MockBuilderSupportedType.generate(elementType: .image, generatorType: .random) as! Image
                            ),
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(), generatorType: .random) as! URL,
                            imageVariable: MockBuilderSupportedType.generate(elementType: .image, generatorType: .random) as! Image
                            ),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
    }
    
    // MARK: Test MockBuilder Macro for class. Class includes all supporeted types variables.
    func testMockBuilderPropertyMacro_all_supported_cases_for_class() throws {
        assertMacroExpansion(
            #"""
            @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
            class ExampleAllSupportedTypes {
                let intVariable: Int
                let int8Variable: Int8
                let int16Variable: Int16
                let int32Variable: Int32
                let int64Variable: Int64
                let uintVariable: UInt
                let uint8Variable: UInt8
                let uint16Variable: UInt16
                let uint32Variable: UInt32
                let uint64Variable: UInt64
                let floatVariable: Float
                let float32Variable: Float32
                let float64Variable: Float64
                let doubleVariable: Double
                let stringVariable: String
                let boolVariable: Bool
                let dateVariable: Date
                let uuidVariable: UUID
                let objectIndetifierVariable: ObjectIdentifier
                let cgPointVariable: CGPoint
                let cgRectVariable: CGRect
                let cgSizeVariable: CGSize
                let cgVectorVariable: CGVector
                let cgFloatVariable: CGFloat
                let urlVariable: URL
                let imageVariable: Image
            }
            """#,
            expandedSource: """
            class ExampleAllSupportedTypes {
                let intVariable: Int
                let int8Variable: Int8
                let int16Variable: Int16
                let int32Variable: Int32
                let int64Variable: Int64
                let uintVariable: UInt
                let uint8Variable: UInt8
                let uint16Variable: UInt16
                let uint32Variable: UInt32
                let uint64Variable: UInt64
                let floatVariable: Float
                let float32Variable: Float32
                let float64Variable: Float64
                let doubleVariable: Double
                let stringVariable: String
                let boolVariable: Bool
                let dateVariable: Date
                let uuidVariable: UUID
                let objectIndetifierVariable: ObjectIdentifier
                let cgPointVariable: CGPoint
                let cgRectVariable: CGRect
                let cgSizeVariable: CGSize
                let cgVectorVariable: CGVector
                let cgFloatVariable: CGFloat
                let urlVariable: URL
                let imageVariable: Image
            
                #if DEBUG
                static var mock: ExampleAllSupportedTypes {
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(), generatorType: .random) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(), generatorType: .random) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(), generatorType: .random) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(), generatorType: .random) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(), generatorType: .random) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(), generatorType: .random) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(), generatorType: .random) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(), generatorType: .random) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(), generatorType: .random) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(), generatorType: .random) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(), generatorType: .random) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(), generatorType: .random) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(), generatorType: .random) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(), generatorType: .random) as! Double,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(), generatorType: .random) as! Bool,
                        dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                        uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(), generatorType: .random) as! UUID,
                        objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                        cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                        cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                        cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                        cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                        cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                        urlVariable: MockBuilderSupportedType.generate(elementType: .url(), generatorType: .random) as! URL,
                        imageVariable: MockBuilderSupportedType.generate(elementType: .image, generatorType: .random) as! Image
                        )
                }
            
                static var mockArray: [ExampleAllSupportedTypes ] {
                    [
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(), generatorType: .random) as! URL,
                            imageVariable: MockBuilderSupportedType.generate(elementType: .image, generatorType: .random) as! Image
                            ),
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(), generatorType: .random) as! URL,
                            imageVariable: MockBuilderSupportedType.generate(elementType: .image, generatorType: .random) as! Image
                            ),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
    }
    
    // MARK: Test Mock Builder Macro for class which has property type of struct
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
                        name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
                        )
                }

                static var mockArray: [Person ] {
                    [
                        .init(
                            name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
                            ),
                        .init(
                            name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
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
                        color: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                        owner: Person.mock
                        )
                }

                static var mockArray: [Car ] {
                    [
                        .init(
                            color: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                            owner: Person.mock
                            ),
                        .init(
                            color: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
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
}
#else
   #warning("macros are only supported when running tests for the host platform")
#endif
