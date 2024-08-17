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
            @MockBuilderProperty(value: 2123.2313123123) let nsDecimalNumberVariable: NSDecimalNumber
            @MockBuilderProperty(value: 8734.3154) let decimalVariable: Decimal
            @MockBuilderProperty(value: "C") let characterVariable: Character
            @MockBuilderProperty(value: "Hello John") let stringVariable: String
            @MockBuilderProperty(value: false) let boolVariable: Bool
            @MockBuilderProperty(value: "https://www.apple.com") let urlVariable: URL
            @MockBuilderProperty(value: Color.blue) let color: Color
            @MockBuilderProperty(value: Image(systemName: "swift")) let image: Image
            @MockBuilderProperty(value: VehicleType.car) let vehicle: VehicleType
        }
        
        enum VehicleType: String, Decodable {
            case car
            case bus
            case motorcycle
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
            let nsDecimalNumberVariable: NSDecimalNumber
            let decimalVariable: Decimal
            let characterVariable: Character
            let stringVariable: String
            let boolVariable: Bool
            let urlVariable: URL
            let color: Color
            let image: Image
            let vehicle: VehicleType

            #if DEBUG
            static var mock: ExampleAllSupportedTypesForMockBuilderProperty {
                .init(
                    intVariable: MockBuilderSupportedType.generate(elementType: .int(12)) as! Int,
                    int8Variable: MockBuilderSupportedType.generate(elementType: .int8(38)) as! Int8,
                    int16Variable: MockBuilderSupportedType.generate(elementType: .int16(1893)) as! Int16,
                    int32Variable: MockBuilderSupportedType.generate(elementType: .int32(89012)) as! Int32,
                    int64Variable: MockBuilderSupportedType.generate(elementType: .int64(31293)) as! Int64,
                    uintVariable: MockBuilderSupportedType.generate(elementType: .uint(381)) as! UInt,
                    uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(71)) as! UInt8,
                    uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(7462)) as! UInt16,
                    uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(9893)) as! UInt32,
                    uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(1934)) as! UInt64,
                    floatVariable: MockBuilderSupportedType.generate(elementType: .float(8933.21)) as! Float,
                    float32Variable: MockBuilderSupportedType.generate(elementType: .float32(849012.3)) as! Float32,
                    float64Variable: MockBuilderSupportedType.generate(elementType: .float64(31213.321)) as! Float64,
                    doubleVariable: MockBuilderSupportedType.generate(elementType: .double(93213.23)) as! Double,
                    nsDecimalNumberVariable: MockBuilderSupportedType.generate(elementType: .nsdecimalnumber(2123.2313123123)) as! NSDecimalNumber,
                    decimalVariable: MockBuilderSupportedType.generate(elementType: .decimal(8734.3154)) as! Decimal,
                    characterVariable: MockBuilderSupportedType.generate(elementType: .character("C")) as! Character,
                    stringVariable: MockBuilderSupportedType.generate(elementType: .string("Hello John")) as! String,
                    boolVariable: MockBuilderSupportedType.generate(elementType: .bool(false)) as! Bool,
                    urlVariable: MockBuilderSupportedType.generate(elementType: .url(URL(string: "https://www.apple.com"))) as! URL,
                    color: MockBuilderSupportedType.generate(elementType: .color(Color.blue)) as! Color,
                    image: MockBuilderSupportedType.generate(elementType: .image(Image(systemName: "swift"))) as! Image,
                    vehicle: VehicleType.car
                    )
            }
        
            static var mockArray: [ExampleAllSupportedTypesForMockBuilderProperty ] {
                [
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(12)) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(38)) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(1893)) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(89012)) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(31293)) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(381)) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(71)) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(7462)) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(9893)) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(1934)) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(8933.21)) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(849012.3)) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(31213.321)) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(93213.23)) as! Double,
                        nsDecimalNumberVariable: MockBuilderSupportedType.generate(elementType: .nsdecimalnumber(2123.2313123123)) as! NSDecimalNumber,
                        decimalVariable: MockBuilderSupportedType.generate(elementType: .decimal(8734.3154)) as! Decimal,
                        characterVariable: MockBuilderSupportedType.generate(elementType: .character("C")) as! Character,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string("Hello John")) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(false)) as! Bool,
                        urlVariable: MockBuilderSupportedType.generate(elementType: .url(URL(string: "https://www.apple.com"))) as! URL,
                        color: MockBuilderSupportedType.generate(elementType: .color(Color.blue)) as! Color,
                        image: MockBuilderSupportedType.generate(elementType: .image(Image(systemName: "swift"))) as! Image,
                        vehicle: VehicleType.car
                        ),
                    .init(
                        intVariable: MockBuilderSupportedType.generate(elementType: .int(12)) as! Int,
                        int8Variable: MockBuilderSupportedType.generate(elementType: .int8(38)) as! Int8,
                        int16Variable: MockBuilderSupportedType.generate(elementType: .int16(1893)) as! Int16,
                        int32Variable: MockBuilderSupportedType.generate(elementType: .int32(89012)) as! Int32,
                        int64Variable: MockBuilderSupportedType.generate(elementType: .int64(31293)) as! Int64,
                        uintVariable: MockBuilderSupportedType.generate(elementType: .uint(381)) as! UInt,
                        uint8Variable: MockBuilderSupportedType.generate(elementType: .uint8(71)) as! UInt8,
                        uint16Variable: MockBuilderSupportedType.generate(elementType: .uint16(7462)) as! UInt16,
                        uint32Variable: MockBuilderSupportedType.generate(elementType: .uint32(9893)) as! UInt32,
                        uint64Variable: MockBuilderSupportedType.generate(elementType: .uint64(1934)) as! UInt64,
                        floatVariable: MockBuilderSupportedType.generate(elementType: .float(8933.21)) as! Float,
                        float32Variable: MockBuilderSupportedType.generate(elementType: .float32(849012.3)) as! Float32,
                        float64Variable: MockBuilderSupportedType.generate(elementType: .float64(31213.321)) as! Float64,
                        doubleVariable: MockBuilderSupportedType.generate(elementType: .double(93213.23)) as! Double,
                        nsDecimalNumberVariable: MockBuilderSupportedType.generate(elementType: .nsdecimalnumber(2123.2313123123)) as! NSDecimalNumber,
                        decimalVariable: MockBuilderSupportedType.generate(elementType: .decimal(8734.3154)) as! Decimal,
                        characterVariable: MockBuilderSupportedType.generate(elementType: .character("C")) as! Character,
                        stringVariable: MockBuilderSupportedType.generate(elementType: .string("Hello John")) as! String,
                        boolVariable: MockBuilderSupportedType.generate(elementType: .bool(false)) as! Bool,
                        urlVariable: MockBuilderSupportedType.generate(elementType: .url(URL(string: "https://www.apple.com"))) as! URL,
                        color: MockBuilderSupportedType.generate(elementType: .color(Color.blue)) as! Color,
                        image: MockBuilderSupportedType.generate(elementType: .image(Image(systemName: "swift"))) as! Image,
                        vehicle: VehicleType.car
                        ),
                ]
            }
            #endif
        }
        
        enum VehicleType: String, Decodable {
            case car
            case bus
            case motorcycle
        }
        """,
        macros: testMacros
        )
    }
}
#endif
