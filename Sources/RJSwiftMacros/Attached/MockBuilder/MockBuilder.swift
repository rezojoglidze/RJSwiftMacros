//
//  MockBuilder.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import Foundation
import RJSwiftCommon

@attached(member, names: named(mock))
public macro MockBuilder(
    numberOfItems: Int,
    dataGeneratorType: DataGeneratorType
) = #externalMacro(module: "RJSwiftMacrosImpl", type: "MockBuilderMacro")
