# RJSwiftMacros

RJSwiftMacros is a Swift package that provides macros.

## Macros

### MockBuilder
- ``MockBuilder(numberOfItems: Int, dataGeneratorType: .random)``: Generates a mock instance and an array of mock data based on your model.
##### Key Features:
- **Default Usage**: `@MockBuilder()` generates a one single mock instance.
- **Customizable**: You can also specify parameters like `numberOfItems` and `dataGeneratorType` if you need to have array of mock items.

> [!WARNING]  
> `MockBuilder` macro doesn't work well at `SwiftUI` `#Preview` macro. Here is a [solution](https://stackoverflow.com/questions/78856674/does-attached-macros-work-in-the-preview-body/78856731#78856731).

### MockBuilderProperty
- ``MockBuilderProperty<T: Any>(value: T)``: Sets an initial value to a property within a struct or class. 

### CodingKeys
- ``CodingKeys(codingKeyType: CodingKeyType)``: Automatically generates `CodingKeys` for a struct based on the specified `CodingKeyType`.
- ``CodingKeyProperty(:_)``: Allows you to adjust the coding key for a specific property.
- ``CodingKeyIgnored()``: Allows you to exclude specific properties from the coding process when using the `CodingKeys` macro.

## Requirements

- Swift 5.10 or later
- macOS 10.15 or later
- iOS 13 or later
- tvOS 13 or later
- watchOS 6 or later

## Installation
**Swift Package Manager**

You can add `RJSwiftMacros` as a dependency in your Project file


## Usage

Import the RJSwiftMacros module and apply the macros to your structs and properties:

Usage of `MockBuilder`: 
```swift
import RJSwiftMacros

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct Person {
    let name: String
    let surname: String
    @MockBuilderProperty(value: "NickNick") let nickName: String
    let closureVariable: (String, Double) -> Void

    #if DEBUG
    static var mock: Person {
        .init(
            name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
            surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
            nickName: MockBuilderSupportedType.generate(elementType: .string("NickNick")) as! String,
            closureVariable: { _, _ in }
            )
    }

    static var mockArray: [Person ] {
        [
            .init(
                name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                nickName: MockBuilderSupportedType.generate(elementType: .string("NickNick")) as! String,
                closureVariable: { _, _ in }
                ),
            .init(
                name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                surname: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
                nickName: MockBuilderSupportedType.generate(elementType: .string("NickNick")) as! String,
                closureVariable: { _, _ in }
                ),
        ]
    }
    #endif
}
```

Usage of `CodingKeys`:
```swift
@CodingKeys()
class Car {
    let modelColor: String
    @CodingKeyProperty("car_model") let model: String
    @CodingKeyIgnored() let speed: Int

    init(modelColor: String, model: String, speed: Int) {
        self.modelColor = modelColor
        self.model = model
        self.speed = speed
    }

    enum CodingKeys: String, CodingKey {
       case modelColor
       case model = "car_model"
    }
}
```

CodingKeys generation with `.snakeCase`.
```swift
@CodingKeys(codingKeyType: .snakeCase)
class Car {
    let modelColor: String
    @CodingKeyProperty("carModel") let model: String
    @CodingKeyIgnored() let speed: Int

    init(modelColor: String, model: String, speed: Int) {
        self.modelColor = modelColor
        self.model = model
        self.speed = speed
    }

    enum CodingKeys: String, CodingKey {
       case modelColor = "model_color
       case model = "carModel"
    }
}
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request on GitHub.


## Contact
For questions or feedback, feel free to reach out to rezojoglidze7@gmail.com.
