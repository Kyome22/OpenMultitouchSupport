// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "OpenMultitouchSupport",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "OpenMultitouchSupport",
            targets: ["OpenMultitouchSupport"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "MultitouchSupport",
            path: "/System/Library/PrivateFrameworks/MultitouchSupport.framework"
        ),
        .target(
            name: "OpenMultitouchSupport",
            dependencies: ["MultitouchSupport"]
        )
    ]
)
