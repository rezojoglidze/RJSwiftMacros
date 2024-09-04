// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "RJSwiftMacros",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .macCatalyst(.v13)
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
            from: "510.0.0"
        )
    ],
    
    targets: [
        .macro(
            name: "RJSwiftMacrosImpl",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        
            .target(
                name: "RJSwiftMacros",
                dependencies: [
                    "RJSwiftMacrosImpl"
                ]
            ),
        
            .executableTarget(
                name: "Example",
                dependencies: [
                    "RJSwiftMacros"
                ]
            ),
        
            .testTarget(
                name: "RJSwiftMacrosTests",
                dependencies: [
                    "RJSwiftMacros",
                    .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                ]
            ),
    ]
)
