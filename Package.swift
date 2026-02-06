// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InkuUI",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18)
    ],
    products: [
        .library(
            name: "InkuUI",
            targets: ["InkuUI"]
        ),
    ],
    targets: [
        .target(
            name: "InkuUI"
        ),
        .testTarget(
            name: "InkuUITests",
            dependencies: ["InkuUI"]
        ),
    ]
)
