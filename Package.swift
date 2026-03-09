// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CandlerModels",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Models",
            targets: ["Models"]),
    ],
    targets: [
        .target(
            name: "Models",
            path: "Sources/Models"),
        .testTarget(
            name: "ModelsTests",
            dependencies: ["Models"],
            path: "Tests"),
    ]
)
