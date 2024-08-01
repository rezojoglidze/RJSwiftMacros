# RJSwiftMacros

RJSwiftMacros is a Swift package that provides macros. Such as generating coding keys and handling coding key properties and ignored keys.

## Features
- ``MockBuilder(numberOfItems: Int, dataGeneratorType: .random)``: Generates an array of mock data from our models.
- ``CodingKeys()``: Automatically generates `CodingKeys` for your structs.
- ``CodingKeyProperty(:_)``: Allows custom coding keys for specific properties.
- ``CodingKeyIgnored()``: Ignores specific properties from the coding process.

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

@MockBuilder(numberOfItems: 3, dataGeneratorType: .random)
struct Person {
    let name: String
    let surname: String

    #if DEBUG
    static var mock: Person {
        .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string())
    }

    static var mockArray: [Person ] {
        [
            .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string()),
            .init(name: DataGenerator.random().string(), surname: DataGenerator.random().string()),
        ]
    }
    #endif
}
```

Usage of `CodingKeys`:
```swift
@CodingKeys
class Car {
    let color: String
    @CodingKeyProperty("car_model") let model: String
    @CodingKeyIgnored() let speed: Int

    init(color: String, model: String, speed: Int) {
        self.color = color
        self.model = model
        self.speed = speed
    }

    enum CodingKeys: String, CodingKey {
       case color
       case model = "car_model"
    }
}
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request on GitHub.


## Contact
For questions or feedback, feel free to reach out to rezojoglidze7@gmail.com.
