//
//  main.swift
//
//
//  Created by Rezo Joglidze on 15.07.24.
//

import Foundation
import RJSwiftMacros
import RJSwiftMacrosImplDependencies

@CodingKeys
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
class Car {
    let color: String
    let model: String
    
    init(color: String, model: String) {
        self.color = color
        self.model = model
    }
}


//Car.mock.forEach({ print("color: ", $0.color, "model: ", $0.model)})
