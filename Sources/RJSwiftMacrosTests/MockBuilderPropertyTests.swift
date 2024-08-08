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
            
                #if DEBUG
                static var mock: ExampleAllSupportedTypes {
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(nil), generatorType: .random) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(nil), generatorType: .random) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(nil), generatorType: .random) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(nil), generatorType: .random) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(nil), generatorType: .random) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(nil), generatorType: .random) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(nil), generatorType: .random) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(nil), generatorType: .random) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(nil), generatorType: .random) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(nil), generatorType: .random) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(nil), generatorType: .random) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(nil), generatorType: .random) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(nil), generatorType: .random) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(nil), generatorType: .random) as! Double,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string(nil), generatorType: .random) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(nil), generatorType: .random) as! Bool,
                        dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                        uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(nil), generatorType: .random) as! UUID,
                        objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                        cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                        cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                        cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                        cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                        cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                        urlVariable: MockBuilderSupportedType.generate(elementType: .url(nil), generatorType: .random) as! URL
                        )
                }
            
                static var mockArray: [ExampleAllSupportedTypes ] {
                    [
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(nil), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(nil), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(nil), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(nil), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(nil), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(nil), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(nil), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(nil), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(nil), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(nil), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(nil), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(nil), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(nil), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(nil), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(nil), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(nil), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(nil), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(nil), generatorType: .random) as! URL
                            ),
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(nil), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(nil), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(nil), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(nil), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(nil), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(nil), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(nil), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(nil), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(nil), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(nil), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(nil), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(nil), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(nil), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(nil), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(nil), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(nil), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(nil), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(nil), generatorType: .random) as! URL
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
            
                #if DEBUG
                static var mock: ExampleAllSupportedTypes {
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(nil), generatorType: .random) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(nil), generatorType: .random) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(nil), generatorType: .random) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(nil), generatorType: .random) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(nil), generatorType: .random) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(nil), generatorType: .random) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(nil), generatorType: .random) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(nil), generatorType: .random) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(nil), generatorType: .random) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(nil), generatorType: .random) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(nil), generatorType: .random) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(nil), generatorType: .random) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(nil), generatorType: .random) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(nil), generatorType: .random) as! Double,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string(nil), generatorType: .random) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(nil), generatorType: .random) as! Bool,
                        dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                        uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(nil), generatorType: .random) as! UUID,
                        objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                        cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                        cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                        cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                        cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                        cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                        urlVariable: MockBuilderSupportedType.generate(elementType: .url(nil), generatorType: .random) as! URL
                        )
                }
            
                static var mockArray: [ExampleAllSupportedTypes ] {
                    [
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(nil), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(nil), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(nil), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(nil), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(nil), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(nil), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(nil), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(nil), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(nil), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(nil), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(nil), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(nil), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(nil), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(nil), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(nil), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(nil), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(nil), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(nil), generatorType: .random) as! URL
                            ),
                        .init(
                            intVariable: MockBuilderSupportedType.generate(elementType: .int(nil), generatorType: .random) as! Int,
                            int8Variable: MockBuilderSupportedType.generate(elementType: .int8(nil), generatorType: .random) as! Int8,
                            int16Variable: MockBuilderSupportedType.generate(elementType: .int16(nil), generatorType: .random) as! Int16,
                            int32Variable: MockBuilderSupportedType.generate(elementType: .int32(nil), generatorType: .random) as! Int32,
                            int64Variable: MockBuilderSupportedType.generate(elementType: .int64(nil), generatorType: .random) as! Int64,
                            uintVariable: MockBuilderSupportedType.generate(elementType: .uint(nil), generatorType: .random) as! UInt,
                            uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(nil), generatorType: .random) as! UInt8,
                            uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(nil), generatorType: .random) as! UInt16,
                            uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(nil), generatorType: .random) as! UInt32,
                            uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(nil), generatorType: .random) as! UInt64,
                            floatVariable: MockBuilderSupportedType.generate(elementType: .float(nil), generatorType: .random) as! Float,
                            float32Variable: MockBuilderSupportedType.generate(elementType: .float32(nil), generatorType: .random) as! Float32,
                            float64Variable: MockBuilderSupportedType.generate(elementType: .float64(nil), generatorType: .random) as! Float64,
                            doubleVariable: MockBuilderSupportedType.generate(elementType: .double(nil), generatorType: .random) as! Double,
                            stringVariable: MockBuilderSupportedType.generate(elementType: .string(nil), generatorType: .random) as! String,
                            boolVariable: MockBuilderSupportedType.generate(elementType: .bool(nil), generatorType: .random) as! Bool,
                            dateVariable: MockBuilderSupportedType.generate(elementType: .date, generatorType: .random) as! Date,
                            uuidVariable: MockBuilderSupportedType.generate(elementType: .uuid(nil), generatorType: .random) as! UUID,
                            objectIndetifierVariable: MockBuilderSupportedType.generate(elementType: .objectidentifier, generatorType: .random) as! ObjectIdentifier,
                            cgPointVariable: MockBuilderSupportedType.generate(elementType: .cgpoint, generatorType: .random) as! CGPoint,
                            cgRectVariable: MockBuilderSupportedType.generate(elementType: .cgrect, generatorType: .random) as! CGRect,
                            cgSizeVariable: MockBuilderSupportedType.generate(elementType: .cgsize, generatorType: .random) as! CGSize,
                            cgVectorVariable: MockBuilderSupportedType.generate(elementType: .cgvector, generatorType: .random) as! CGVector,
                            cgFloatVariable: MockBuilderSupportedType.generate(elementType: .cgfloat, generatorType: .random) as! CGFloat,
                            urlVariable: MockBuilderSupportedType.generate(elementType: .url(nil), generatorType: .random) as! URL
                            ),
                    ]
                }
                #endif
            }
            """,
            macros: testMacros
        )
    }
    
    func testMockBuilderPropertyMacro_for_MockBuilderProperty_builder() throws {
        assertMacroExpansion(
        #"""
        @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
        struct ExampleAllSupportedTypesForMockBuilderProperty {
            @MockBuilderProperty(value: 12) let intVariable: Int
            @MockBuilderProperty(value: 38) let int8Variable: Int8
            @MockBuilderProperty(value: 1893) let int16Variable: Int16
            @MockBuilderProperty(value: 89012) let int32Variable: Int32
            @MockBuilderProperty(value: 31293) let int64Variable: Int64
            @MockBuilderProperty(value: 381) let uintVariable: UInt
            @MockBuilderProperty(value: 71) let uint8Variable: UInt8
            @MockBuilderProperty(value: 7462) let uint16Variable: UInt16
            @MockBuilderProperty(value: 9893) let uint32Variable: UInt32
            @MockBuilderProperty(value: 1934) let uint64Variable: UInt64
            @MockBuilderProperty(value: 8933.21) let floatVariable: Float
            @MockBuilderProperty(value: 849012.31) let float32Variable: Float32
            @MockBuilderProperty(value: 31213.321) let float64Variable: Float64
            @MockBuilderProperty(value: 93213.23) let doubleVariable: Double
            @MockBuilderProperty(value: "Hello John") let stringVariable: String
            @MockBuilderProperty(value: false) let boolVariable: Bool
        }
        """#,
        expandedSource:"""
        struct ExampleAllSupportedTypesForMockBuilderProperty {
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
        
            #if DEBUG
            static var mock: ExampleAllSupportedTypesForMockBuilderProperty {
                .init(
                    intVariable: MockBuilderSupportedType.generate(elementType: .int(12), generatorType: .random) as! Int,
                    int8Variable: MockBuilderSupportedType.generate(elementType: .int8(38), generatorType: .random) as! Int8,
                    int16Variable: MockBuilderSupportedType.generate(elementType: .int16(1893), generatorType: .random) as! Int16,
                    int32Variable: MockBuilderSupportedType.generate(elementType: .int32(89012), generatorType: .random) as! Int32,
                    int64Variable: MockBuilderSupportedType.generate(elementType: .int64(31293), generatorType: .random) as! Int64,
                    uintVariable: MockBuilderSupportedType.generate(elementType: .uint(381), generatorType: .random) as! UInt,
                    uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(71), generatorType: .random) as! UInt8,
                    uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(7462), generatorType: .random) as! UInt16,
                    uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(9893), generatorType: .random) as! UInt32,
                    uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(1934), generatorType: .random) as! UInt64,
                    floatVariable: MockBuilderSupportedType.generate(elementType: .float(8933.21), generatorType: .random) as! Float,
                    float32Variable: MockBuilderSupportedType.generate(elementType: .float32(849012.3), generatorType: .random) as! Float32,
                    float64Variable: MockBuilderSupportedType.generate(elementType: .float64(31213.321), generatorType: .random) as! Float64,
                    doubleVariable: MockBuilderSupportedType.generate(elementType: .double(93213.23), generatorType: .random) as! Double,
                    stringVariable: MockBuilderSupportedType.generate(elementType: .string("Hello John"), generatorType: .random) as! String,
                    boolVariable: MockBuilderSupportedType.generate(elementType: .bool(false), generatorType: .random) as! Bool
                    )
            }
        
            static var mockArray: [ExampleAllSupportedTypesForMockBuilderProperty ] {
                [
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(12), generatorType: .random) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(38), generatorType: .random) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(1893), generatorType: .random) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(89012), generatorType: .random) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(31293), generatorType: .random) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(381), generatorType: .random) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(71), generatorType: .random) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(7462), generatorType: .random) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(9893), generatorType: .random) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(1934), generatorType: .random) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(8933.21), generatorType: .random) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(849012.3), generatorType: .random) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(31213.321), generatorType: .random) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(93213.23), generatorType: .random) as! Double,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string("Hello John"), generatorType: .random) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(false), generatorType: .random) as! Bool
                        ),
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(12), generatorType: .random) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(38), generatorType: .random) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(1893), generatorType: .random) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(89012), generatorType: .random) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(31293), generatorType: .random) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(381), generatorType: .random) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(71), generatorType: .random) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(7462), generatorType: .random) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(9893), generatorType: .random) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(1934), generatorType: .random) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(8933.21), generatorType: .random) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(849012.3), generatorType: .random) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(31213.321), generatorType: .random) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(93213.23), generatorType: .random) as! Double,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string("Hello John"), generatorType: .random) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(false), generatorType: .random) as! Bool
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

#endif





