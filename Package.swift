// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "AppIconGenerator",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "AppIconGenerator",
            targets: ["AppIconGenerator"]
        )
    ],
    targets: [
        .target(
            name: "AppIconGenerator",
            dependencies: []
        ),
        .testTarget(
            name: "AppIconGeneratorTests",
            dependencies: ["AppIconGenerator"]
        )
    ]
)
