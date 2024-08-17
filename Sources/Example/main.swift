//
//  main.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//`

import SwiftUI
import RJSwiftMacros
import RJSwiftCommon
import RJSwiftMacrosImplDependencies


@CodingKeys()
@MockBuilder(numberOfItems: 1, dataGeneratorType: .default)
struct CarModel: Decodable {
   @CodingKeyIgnored() var title: String?
    
    var closure: (() -> ())?

    let print: String
    let cars: [Car]
    
    @CodingKeys()
    @MockBuilder(numberOfItems: 5, dataGeneratorType: .default)
    struct Car: Decodable {
       @MockBuilderProperty(value: 2) let title: String
        let description: String
    }
}


@CodingKeys(codingKeyType: .snakeCase)
@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct Person {
    let name: String?
    
    @CodingKeyProperty("second_name")
    let surname: [String?]?
    
    @MockBuilderProperty(value: Color.blue)
    let color: Color?
    
    @MockBuilderProperty(value: Image(systemName: "swift"))
    let image: Image?
    
    let closureVariable: () -> Void
    @MockBuilderProperty(value: "k") let character: Character
}


@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct ExampleAllSupportedTypesd: Equatable {
    var uuid: UUID = .init()
    @MockBuilderProperty(value: "StringVariable") let mockVariable: String
    @MockBuilderProperty(value: "C") let characterVariable: Character
}

print(ExampleAllSupportedTypesd.mock.characterVariable)

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
enum VehicleType: String, Decodable {
    case car
    case bus
    case motorcycle
}

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct University {
    @MockBuilderProperty(value: 4500) let price: Int
    @MockBuilderProperty(value: "TSU") let name: String
    let president: Person
    let students: [Person]
    let privateVehicles: [VehicleType]?
    @MockBuilderProperty(value: false) let isFree: Bool
    let image: Image
    
    var oldName: String {
        "Tbilisi"
    }
}

print("Universicty monthly price: ", University.mock.price)

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
    let decimalVariable: Decimal
    let nsDecimalNumberVariable: NSDecimalNumber
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

print("ExampleAllSupportedTypes.mock: ", ExampleAllSupportedTypes.mock.stringVariable)


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
    @MockBuilderProperty(value: "Hello John") let stringVariable: String
    @MockBuilderProperty(value: false) let boolVariable: Bool
    @MockBuilderProperty(value: "https://www.apple.com") let urlVariable: URL
}

print(ExampleAllSupportedTypesForMockBuilderProperty.mock.urlVariable.absoluteString)
