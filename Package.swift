// swift-tools-version: 6.2

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "OpenMultitouchSupport",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(
            name: "OpenMultitouchSupport",
            targets: ["OpenMultitouchSupport"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-async-algorithms.git", from: "1.1.4"),
    ],
    targets: [
        .binaryTarget(
            name: "OpenMultitouchSupportXCF",
            url: "https://github.com/Kyome22/OpenMultitouchSupport/releases/download/4.0.0/OpenMultitouchSupportXCF.xcframework.zip",
            checksum: "270d0b70d2dfa935f846b54d53004ec8bd6a0588996f56a0c06e5b39bab5afd4"
        ),
        .target(
            name: "OpenMultitouchSupport",
            dependencies: [
                "OpenMultitouchSupportXCF",
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)
