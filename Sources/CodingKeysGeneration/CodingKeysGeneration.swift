//
//  CodingKeysGeneration.swift
//  
//
//  Created by Rezo Joglidze on 14.07.24.
//

import Foundation

@attached(member, names: named(CodingKeys))
public macro CodingKeys() = #externalMacro(module: "CodingKeysGenerationMacros", type: "CodingKeysMacro")
