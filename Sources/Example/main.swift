//
//  main.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//

import Foundation
import RJSwiftMacros
import RJSwiftMacrosImplDependencies

@CodingKeys(codingKeyType: .camelCase)
@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct Person {
    let nameGric: String
    @CodingKeyProperty("second_name") let surname: String
}

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
enum VehicleType: String {
    case car
    case bus
    case motorcycle
}

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
