//
//  DataGeneratorModel.swift
//
//
//  Created by Rezo Joglidze on 05.08.24.
//

import Foundation

public struct DataGeneratorModel {
    public let elementType: MockBuilderSupportedType
    public let generatorType: DataGeneratorType
    
    public init(
        elementType: MockBuilderSupportedType,
        generatorType: DataGeneratorType
    ) {
        self.elementType = elementType
        self.generatorType = generatorType
    }
}
