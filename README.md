# RJSwiftMacros

RJSwiftMacros is a Swift package that provides macros.

> [!TIP]
> I used all macros in my SwiftUIDemo project. see the [LINK](https://github.com/rezojoglidze/SwiftUIDemo).

## Macros

> [!WARNING]  
> `MockBuilder` macro doesn't work at `SwiftUI` `#Preview` macro. Here is a [solution](https://stackoverflow.com/questions/78856674/does-attached-macros-work-in-the-preview-body/78856731#78856731).

### MockBuilder
- ``MockBuilder(numberOfItems: Int)``: Generates a mock instance and an array of mock data based on your model.
- `MockBuilder` has `MockBuilderProperty` member macro, with which you can set the initial value to the desired property.
  
##### Key Features:
- **Default Usage**: `@MockBuilder()` generates a one single mock instance.
- **Customizable**: You can also specify parameter like `numberOfItems` if you need to have array of mock items.

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
Macro generates two `static` properties: `mock` and `mockArray`. `mockArray` count equals `numberOfItems` value. If you want to set a custom value to the desired property, use `@MockBuilderProperty` macro. If the custom value granted is prohibited you will get a swift standard warning error. <img width="470" alt="image" src="https://github.com/user-attachments/assets/5467a640-0923-4421-9680-f7ae8e743e59">

To generate only `.mock` value, you can use `@MockBuilder()` without any param passing.
> [!IMPORTANT]  
> Type which participating in the mock building should have `@MockBuilder()` itself. Below example, we want to have `let type: VehicleType` mocked version, so `VehicleType` should have `@MockBuilder()`
```swift
import RJSwiftMacros

@MockBuilder(numberOfItems: 2)
enum VehicleType: String, Decodable {
    case car
    case bus
    case motorcycle
}

@MockBuilder()
struct Car {
    let name: String
    @MockBuilderProperty(value: "John") let ownerName: String
    let closureVariable: (String, Double) -> Void
    let carColor: Color
    @MockBuilderProperty(value: VehicleType.car) let type: VehicleType

    #if DEBUG
    static var mock: Car {
        .init(
            name: "John",
            ownerName: "Nick",
            closureVariable: { _, _ in },
            carColor: Color.gray.opacity(0.6),
            type: VehicleType.car
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
    
    @MockBuilderProperty(value: Color.blue) let color: Color?
    @MockBuilderProperty(value: Image(systemName: "swift")) let image: Image?
    @MockBuilderProperty(value: "k") let character: Character

    #if DEBUG
    static var mock: Person {
        .init(
            name: "Lorna,
            surname: ["Clare"],
            color: Color.blue.opacity(0.6),
            image: Image(systemName: "swift"),
            character: "k"
            )
    }

    static var mockArray: [Person ] {
        [
           .init(
               name: "Valentina,
               surname: ["Queenie"],
               color: Color.blue.opacity(0.6),
               image: Image(systemName: "swift"),
               character: "k"
               ),
           .init(
               name: "Lorna,
               surname: ["Bettye"],
               color: Color.blue.opacity(0.6),
               image: Image(systemName: "swift"),
               character: "k"
               )
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
- iOS 15 or later
  
## Contributing
Contributions are welcome! Please open an issue or submit a pull request on GitHub.


## Contact
For questions or feedback, feel free to reach out to rezojoglidze7@gmail.com.
