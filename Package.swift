// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-jira",
    platforms: [
        .macOS(.v10_15),

        // The platforms below are not currently supported for running
        // the generator itself. We include them here to allow the generator
        // to emit a more descriptive compiler error.
        .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1),
    ],
    products: [
        .library(
            name: "swift-jira",
            targets: ["swift-jira"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "swift-jira",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ]
        ),
        .testTarget(
            name: "swift-jiraTests",
            dependencies: ["swift-jira"]
        ),
    ]
)
