// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NativeblocksFoundation",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NativeblocksFoundation",
            targets: ["NativeblocksFoundation"]
        ),
    ],
    dependencies: [
        .package(url: "git@github.com:nativeblocks/nativeblocks-ios-sdk.git", branch: "main"),
        .package(url: "https://github.com/nativeblocks/nativeblocks-compiler-ios.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "NativeblocksFoundation",
            dependencies: [
                .product(name: "Nativeblocks", package: "nativeblocks-ios-sdk"),
                .product(name: "NativeblocksCompiler", package: "nativeblocks-compiler-ios"),
            ]
        ),
        .testTarget(
            name: "NativeblocksFoundationTests",
            dependencies: ["NativeblocksFoundation"]
        ),
    ]
)
