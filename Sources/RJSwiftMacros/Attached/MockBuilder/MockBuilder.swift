//
//  MockBuilder.swift
//
//
//  Created by Rezo Joglidze on 27.07.24.
//

import Foundation
import RJSwiftCommon
import RJSwiftMacrosImplDependencies

/// - `MockBuilder(numberOfItems: Int, dataGeneratorType: .random)`: This macro generates a mock instance and an array of mock data based on your model. It allows you to specify the number of items and the type of data generation strategy (`.random` in this case or `.default`), making it highly flexible for testing and development purposes.
/// ```
///  import RJSwiftMacros
///
///  @MockBuilder(numberOfItems: 3, dataGeneratorType: .random)
///  struct Person {
///      let name: String
///      let surname: String
///
///      #if DEBUG
///      static var mock: Person {
///          .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string())
///      }
///
///      static var mockArray: [Person ] {
///          [
///              .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string()),
///              .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string()),
///          ]
///      }
///      #endif
///  }
///}
///```
@attached(member, names: named(mock), named(mockArray))
public macro MockBuilder(
    numberOfItems: Int,
    dataGeneratorType: DataGeneratorType
) = #externalMacro(module: "RJSwiftMacrosImpl", type: "MockBuilderMacro")


/// - `MockBuilderProperty<T: Any>(value: T)`: This macro sets an initial value to a property within a struct or class. It is a generic macro, meaning it can accept any type (T) as a parameter.
///  If the provided type is unsupported, a warning message will be displayed. This macro is particularly useful in scenarios where you need to initialize properties with specific values.
/// ```
///  import RJSwiftMacros
///
///  @MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
///  struct Person {
///      @MockBuilderProperty(value: "John") let name: String
///      let surname: String
///
///      #if DEBUG
///      static var mock: Person {
///          .init(
///              name: MockBuilderSupportedType.generate(elementType: .string("John")) as! String,
///              surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
///              )
///      }
///
///      static var mockArray: [Person ] {
///          [
///              .init(
///                  name: MockBuilderSupportedType.generate(elementType: .string("John")) as! String,
///                  surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
///                  ),
///              .init(
///                  name: MockBuilderSupportedType.generate(elementType: .string("John")) as! String,
///                  surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String
///                  ),
///          ]
///      }
///      #endif
///  }
///```
@attached(peer)
public macro MockBuilderProperty<T: Any>(value: T) = #externalMacro(module: "RJSwiftMacrosImpl", type: "MockBuilderPropertyMacro")
