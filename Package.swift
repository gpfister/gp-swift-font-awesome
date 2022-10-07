// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FASwiftUI",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v11),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "FASwiftUI5",
            targets: ["FASwiftUI5"]
        ),
        .library(
            name: "FASwiftUI6",
            targets: ["FASwiftUI6"]
        ),
    ],
    targets: [
        .target(
            name: "FASwiftUI5"
        ),
        .target(
            name: "FASwiftUI6"
        ),
    ]
)
