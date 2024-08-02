//
//  main.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//

import Foundation
import RJSwiftMacros
import RJSwiftMacrosImplDependencies

@CodingKeys(codingKeyType: .snakeCase)
@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct Person {
    @CodingKeyIgnored() let name: String
    let surname: String
}

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
enum VehicleType: String {
    case car
    case bus
    case motorcycle
}

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct University {
    let name: String
    let president: Person
    let students: [Person]
    let privateVehicles: [VehicleType]
        
    var oldName: String {
        "Tbilisi"
    }
    
    init(
        name: String,
        president: Person,
        students: [Person],
        privateVehicles: [VehicleType]
    ) {
        self.name = name
        self.president = president
        self.students = students
        self.privateVehicles = privateVehicles
    }
}
