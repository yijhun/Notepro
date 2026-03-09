// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CandlerModels",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CandlerModels",
            targets: ["CandlerModels"]),
    ],
    targets: [
        .target(
            name: "CandlerModels",
            path: "Sources/Models"),
        .testTarget(
            name: "CandlerModelsTests",
            dependencies: ["CandlerModels"],
            path: "Tests/ModelsTests"),
    ]
)
