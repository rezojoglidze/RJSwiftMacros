//
//  Example.swift
//  
//
//  Created by Rezo Joglidze on 15.07.24.
//

import Foundation
import RJSwiftMacros
import CodingKeysGeneration

@CodingKeys
struct Car {
    let name: String
    @CodingKeyProperty("second_name") let surname: String
    @CodingKeyIgnored() let color: String
}
