// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppIconGenerator",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "AppIconGenerator",
            targets: ["AppIconGenerator"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppIconGenerator",
            dependencies: [],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
