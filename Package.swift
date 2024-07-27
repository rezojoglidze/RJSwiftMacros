// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "RJSwiftMacros",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)
    ],
    
    products: [
        .library(
            name: "RJSwiftMacros",
            targets: ["RJSwiftMacros"]
        )
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "509.0.0"
        )
    ],
    
    targets: [
        .macro(
            name: "RJSwiftMacrosImpl",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                "RJSwiftCommon"
            ]
        ),
        
            .target(
                name: "RJSwiftMacros",
                dependencies: ["RJSwiftMacrosImpl", "RJSwiftCommon"]
            ),
        
            .target(
                name: "RJSwiftCommon",
                dependencies: [.product(name: "SwiftSyntaxMacros", package: "swift-syntax")]
            ),
        
            .executableTarget(name: "Example", dependencies: ["RJSwiftMacrosImpl", "RJSwiftMacros"]),
        
            .testTarget(
                name: "RJSwiftMacrosTests",
                dependencies: [
                    "RJSwiftMacros",
                    "RJSwiftMacrosImpl",
                    .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                ]
            ),
    ]
)
