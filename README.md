# RJSwiftMacros

RJSwiftMacros is a Swift package that provides macros.

## Macros

> [!WARNING]  
> `MockBuilder` macro doesn't work at `SwiftUI` `#Preview` macro. Here is a [solution](https://stackoverflow.com/questions/78856674/does-attached-macros-work-in-the-preview-body/78856731#78856731).

### MockBuilder
- ``MockBuilder(numberOfItems: Int, dataGeneratorType: .random)``: Generates a mock instance and an array of mock data based on your model.
- `MockBuilder` has `MockBuilderProperty` member macro, with which you can set the initial value to the desired property.
  
##### Key Features:
- **Default Usage**: `@MockBuilder()` generates a one single mock instance.
- **Customizable**: You can also specify parameters like `numberOfItems` and `dataGeneratorType` if you need to have array of mock items.

#### MockBuilderProperty macro
- ``MockBuilderProperty<T: Any>(value: T)``: Sets an initial value to a property within a struct or class. 

### CodingKeys
- ``CodingKeys(codingKeyType: CodingKeyType)``: Automatically generates `CodingKeys` for a struct based on the specified `CodingKeyType` which has two cases: `.camelCase` and `.snakeCase`.
- ``CodingKeyProperty(:_)``: Allows you to adjust the coding key for a specific property.
- ``CodingKeyIgnored()``: Allows you to exclude specific properties from the coding process when using the `CodingKeys` macro.



## Installation
**Swift Package Manager**

To depend on `RJSwiftMacros` in a SwiftPM package, add the following to your Package.swift.

```swift
dependencies: [
  .package(url: "https://github.com/rezojoglidze/RJSwiftMacros", from: "<#latest RJSwiftMacros tag#>"),
],
```
To add `RJSwiftMacros` as a dependency of your Xcode project, go to the Package Dependencies tab of your Xcode project, click the plus button and search for https://github.com/rezojoglidze/RJSwiftMacros

## Usage

### MockBuilder macro
Import the RJSwiftMacros module and apply the macros to your structs and properties:

Usage of `MockBuilder`: 
Macro generates two `static` properties: `mock` and `mockArray`. `mockArray` count equals `numberOfItems` value. `dataGeneratorType` is `.random` default. If you want to set a custom value to the desired property, use `@MockBuilderProperty` macro. If the custom value granted is prohibited you will get a swift standard warning error. <img width="461" alt="image" src="https://github.com/user-attachments/assets/3a559982-d70b-4d91-a2a4-5b9f08cebdf4">

To generate only `.mock` value, you can use `@MockBuilder()` without any param passing.
```swift
import RJSwiftMacros

@MockBuilder()
struct Car {
    let name: String
    @MockBuilderProperty(value: "John") let ownerName: String
    let closureVariable: (String, Double) -> Void
    let carColor: Color

    #if DEBUG
    static var mock: Car {
        .init(
            name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String,
            ownerName: MockBuilderSupportedType.generate(elementType: .string("John")) as! String,
            closureVariable: { _, _ in },
            carColor: MockBuilderSupportedType.generate(elementType: .color(), generatorType: .random) as! Color
            )
    }
    #endif
}
```

To generate both `.mock` and `.mockArray` properties user `@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)`. `numberOfItems` is equal to the count of mock array.
```swift
import RJSwiftMacros

@MockBuilder(numberOfItems: 2, dataGeneratorType: .random)
struct Person {
    let name: String?
    
    let surname: [String]?
    
    @MockBuilderProperty(value: Color.blue)
    let color: Color?
    
    @MockBuilderProperty(value: Image(systemName: "swift"))
    let image: Image?
    
    @MockBuilderProperty(value: "k") let character: Character

    #if DEBUG
    static var mock: Person {
        .init(
            name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as? String,
            surname: [MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String],
            color: MockBuilderSupportedType.generate(elementType: .color(Color.blue)) as! Color,
            image: MockBuilderSupportedType.generate(elementType: .image(Image(systemName: "swift"))) as! Image,
            character: MockBuilderSupportedType.generate(elementType: .character("k")) as! Character
            )
    }

    static var mockArray: [Person ] {
        [
            .init(
                name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as? String,
                surname: [MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String],
                color: MockBuilderSupportedType.generate(elementType: .color(Color.blue)) as! Color,
                image: MockBuilderSupportedType.generate(elementType: .image(Image(systemName: "swift"))) as! Image,
                character: MockBuilderSupportedType.generate(elementType: .character("k")) as! Character
                ),
            .init(
                name: MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as? String,
                surname: [MockBuilderSupportedType.generate(elementType: .string(), generatorType: .random) as! String],
                color: MockBuilderSupportedType.generate(elementType: .color(Color.blue)) as! Color,
                image: MockBuilderSupportedType.generate(elementType: .image(Image(systemName: "swift"))) as! Image,
                character: MockBuilderSupportedType.generate(elementType: .character("k")) as! Character
                ),
        ]
    }
    #endif
}
```

### CodingKeys macro
Usage of `CodingKeys` without `codingKeyType` param passing generates CodingKeys with `.camelCase`. `CodingKeys` macro works only with stored property types. If you want to set custom coding key to the desired param, use `@CodingKeyProperty(desired_value)`. To ignore desired param from `CodingKeys` enum, use `@CodingKeyIgnored()`.
```swift
import RJSwiftMacros

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
import RJSwiftMacros

@CodingKeys(codingKeyType: .snakeCase)
struct University {
    let name: String
    let studentCapacity: Int
    let cars: [String]?
    var closure: (() -> ())?

    static var students: [String] = []
    
    var oldName: String {
        "Tbilisi"
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case studentCapacity = "student_capacity"
        case cars = "cars"
    }
}
```

## Requirements

- Swift 5.10 or later
- macOS 10.15 or later
- iOS 13 or later
- tvOS 13 or later
- watchOS 6 or later
  
## Contributing
Contributions are welcome! Please open an issue or submit a pull request on GitHub.


## Contact
For questions or feedback, feel free to reach out to rezojoglidze7@gmail.com.
