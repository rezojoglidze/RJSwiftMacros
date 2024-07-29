//
//  main.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//

import Foundation
import RJSwiftMacros
import RJSwiftCommon
import RJSwiftMacrosImpl

@CodingKeys
struct Car {
    let name: String
    @CodingKeyProperty("model_name") let model: String
    @CodingKeyIgnored() let color: String
}

@MockBuilder(numberOfItems: 3, dataGeneratorType: .random)
struct Person {
    let name: String
    let surname: String
}

Person.mock.forEach({ print("name: ", $0.name, "surname: ", $0.surname)})
