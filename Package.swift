// swift-tools-version: 6.0

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "OpenMultitouchSupport",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "OpenMultitouchSupport",
            targets: ["OpenMultitouchSupport"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "OpenMultitouchSupportXCF",
            url: "https://github.com/Kyome22/OpenMultitouchSupport/releases/download/3.0.0/OpenMultitouchSupportXCF.xcframework.zip",
            checksum: "9d430a4f675bddd4996405a45fcc1e0584d1f7a975c75c0e829915c15788a03c"
        ),
        .target(
            name: "OpenMultitouchSupport",
            dependencies: ["OpenMultitouchSupportXCF"],
            swiftSettings: swiftSettings
        )
    ]
)
