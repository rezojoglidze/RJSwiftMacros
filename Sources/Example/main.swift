//
//  main.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//

import Foundation
import RJSwiftMacros
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

@CodingKeys(codingKeyType: .snakeCase)
@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct Person {
    let name: String
    @CodingKeyProperty("second_name") let surname: String
}

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
enum VehicleType: String {
    case car
    case bus
    case motorcycle
}

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct University {
    @MockBuilderProperty(value: 45) let price: Int
    @MockBuilderProperty(value: "Rezzz") let name: String
    let president: Person
    let students: [Person]
    let privateVehicles: [VehicleType]
    @MockBuilderProperty(value: true) let isFree: Bool
    
    var oldName: String {
        "Tbilisi"
    }
}

print("Universicty monthly price: ", University.mock.price)
