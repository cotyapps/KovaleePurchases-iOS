// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KovaleePurchases",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "KovaleePurchases",
            targets: [
                "KovaleePurchases",
                "KovaleePaywall",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/cotyapps/Kovalee-iOS-SDK", from: Version(1, 10, 7)),
        .package(url: "https://github.com/RevenueCat/purchases-ios", from: Version(5, 0, 0)),
        .package(url: "https://github.com/cotyapps/KovaleeRemoteConfig-iOS", .upToNextMajor(from: Version(1, 0, 0))),
        .package(url: "https://github.com/superwall-me/Superwall-iOS", .upToNextMajor(from: Version(3, 0, 0))),
    ],
    targets: [
        .target(
            name: "KovaleePurchases",
            dependencies: [
                .SDK,
                .revenueCat,
                .superwall,
                .remoteConfig,
            ],
            resources: [
                .copy("PrivacyInfo.xcprivacy"),
            ]
        ),
        .target(
            name: "KovaleePaywall",
            dependencies: [
                .superwall,
                .SDK,
                .remoteConfig,
                "KovaleePurchases",
            ]
        ),
    ]
)

extension Target.Dependency {
    static var SDK: Self {
        .product(name: "KovaleeSDK", package: "Kovalee-iOS-SDK")
    }

    static var remoteConfig: Self {
        .product(name: "KovaleeRemoteConfig", package: "KovaleeRemoteConfig-iOS")
    }

    static var revenueCat: Self {
        .product(name: "RevenueCat", package: "purchases-ios")
    }

    static var superwall: Self {
        .product(name: "SuperwallKit", package: "Superwall-iOS")
    }
}
