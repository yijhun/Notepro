// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ProductivityApp",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "ProductivityModels",
            targets: ["Models"]),
    ],
    targets: [
        .target(
            name: "Models",
            path: "Sources/Models"),
    ]
)
