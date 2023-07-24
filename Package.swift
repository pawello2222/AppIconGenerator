// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AppIconGenerator",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "AppIconGenerator",
            targets: ["AppIconGenerator"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppIconGenerator",
            dependencies: [],
            path: "Sources"
        )
    ]
)
