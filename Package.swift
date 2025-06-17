// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NativeblocksFoundation",
    platforms: [.iOS(.v15), .macOS(.v13)],
    products: [
        .library(
            name: "NativeblocksFoundation",
            targets: ["NativeblocksFoundation"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/nativeblocks/nativeblocks-ios-sdk", .upToNextMajor(from: "1.4.0")),
        .package(url: "https://github.com/nativeblocks/nativeblocks-compiler-ios", .upToNextMajor(from: "1.2.2")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.1.1")),
    ],
    targets: [
        .target(
            name: "NativeblocksFoundation",
            dependencies: [
                .product(name: "Nativeblocks", package: "nativeblocks-ios-sdk"),
                .product(name: "NativeblocksCompiler", package: "nativeblocks-compiler-ios"),
                .product(name: "Kingfisher", package: "Kingfisher"),
            ]
        ),
        .testTarget(
            name: "NativeblocksFoundationTests",
            dependencies: ["NativeblocksFoundation"]
        ),
    ]
)
