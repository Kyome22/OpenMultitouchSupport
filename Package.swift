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
            url: "https://github.com/Kyome22/OpenMultitouchSupport/releases/download/3.0.3/OpenMultitouchSupportXCF.xcframework.zip",
            checksum: "9ffe72a65f0107e87a003485ab9530e772a6b45953af2f7d0cc41665d1873dea"
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
