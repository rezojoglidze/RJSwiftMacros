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
@MockBuilder(numberOfItems: 3, dataGeneratorType: .random)
struct Person {
    let name: String
    @CodingKeyProperty("second_name") let surname: String
}

Person.mock.forEach({ print("name: ", $0.name, "surname: ", $0.surname)})
