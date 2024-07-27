//
//  Example.swift
//  
//
//  Created by Rezo Joglidze on 15.07.24.
//

import Foundation
import RJSwiftMacros
//import RJSwiftMacrosImpl

@CodingKeys
struct Car {
    let name: String
    @CodingKeyProperty("second_name") let surname: String
    @CodingKeyIgnored() let color: String
}


//@MockBuilder(numberOfItems: 12, dataGeneratorType: .random)
//struct Person {
//    let name: String
//    let surname: String = DataGenerator.random.string()
//}
