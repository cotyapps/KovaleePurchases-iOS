# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.4] - 2024-04-23
### :sparkles: New Features
- [`6288658`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/6288658b4c48e30b8459582e6df93a4cabc738ea) - duplicated functions with async code to have completion blocks interface *(commit by [@fto-k](https://github.com/fto-k))*


## [1.5.3] - 2024-04-19
### :wrench: Chores
- [`6adc625`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/6adc62551670a467621c7900464121e8a453654c) - updated minumum dependency version in podspecs *(commit by [@fto-k](https://github.com/fto-k))*


## [1.5.2] - 2024-04-15
### :wrench: Chores
- [`00891b4`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/00891b4c65704540aaa61d899f25894b7bc4bd1d) - updated privacy manifest *(commit by [@fto-k](https://github.com/fto-k))*


## [1.5.1] - 2024-04-15
### :wrench: Chores
- [`2cdf6f0`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/2cdf6f03fc9223fc64b9f63e3c3b402cab91f352) - set minimum KovaleeSDK version *(commit by [@fto-k](https://github.com/fto-k))*
- [`3765216`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/3765216f122ccaa0888f69a42a8c46f7ebb265a3) - updated privacy manifest *(commit by [@fto-k](https://github.com/fto-k))*


## [1.4.0] - 2024-04-15
### :sparkles: New Features
- [`46a6508`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/46a6508c9560121fa232c6ff888740be7bcde5be) - new library to handle paywall presentation using Superwall *(commit by [@fto-k](https://github.com/fto-k))*
- [`5138ae9`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/5138ae94bc05010803d2cfd521a4f9e3ef863585) - introducing PaywallViewController to present paywalls in UIKit *(commit by [@fto-k](https://github.com/fto-k))*
- [`9af4bb4`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/9af4bb4f7b5a072caa90a348f0b93a5cd726448b) - adding viewController to completion block to dismiss paywall *(commit by [@fto-k](https://github.com/fto-k))*
- [`2f6f999`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/2f6f9995a9a7ee54b3491f3f680762ed2b980678) - implemented SuperviewViewController *(commit by [@fto-k](https://github.com/fto-k))*
- [`c428867`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/c428867b7edcca62d8eb857ebbc9e4f665145f94) - implemented extension to present KPaywallViewController *(commit by [@fto-k](https://github.com/fto-k))*
- [`d166fe8`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/d166fe8a07a048bd220f70e7b7459fe0c11e8762) - adde parameter to handle forcing AB variants *(commit by [@fto-k](https://github.com/fto-k))*
- [`6b8935e`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/6b8935ef62c6709e738ed97a16becd7ccd3c6f5d) - allowing Alternative Paywall injection in case of error presenting SW one *(commit by [@fto-k](https://github.com/fto-k))*
- [`72eb8cb`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/72eb8cb468cea8c4babb94ebe5d9c92c672ed486) - AB test handling for alternative paywalls *(commit by [@fto-k](https://github.com/fto-k))*
- [`bf0b92e`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/bf0b92e0b8aeb01e071ad902f02ea68eba4499a5) - AB test handling for alternative paywalls *(commit by [@fto-k](https://github.com/fto-k))*

### :bug: Bug Fixes
- [`ffe6568`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/ffe6568a53c60b600b1bd109d5d8a26984f01e9b) - KPaywallViewController interface public *(commit by [@fto-k](https://github.com/fto-k))*
- [`86a4013`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/86a401398fe870868614486106ac11b767e1a012) - cleaned up implementation *(commit by [@fto-k](https://github.com/fto-k))*
- [`88f1dda`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/88f1dda224a956c1c8b1e73086c0da98722e1fd7) - setting correct paywall view event + code cleanup *(commit by [@fto-k](https://github.com/fto-k))*
- [`93a2727`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/93a2727520dc20a004eaa2f80ab03d4f0c66f37f) - fixed events sending order *(commit by [@fto-k](https://github.com/fto-k))*

### :wrench: Chores
- [`f267401`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/f26740115d43eb4bed3ad14d28f2fc19d8a05a42) - code refactoring *(commit by [@fto-k](https://github.com/fto-k))*
- [`75b6cff`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/75b6cfff5b444657eddf76b009818435746c8ba0) - added documentation *(commit by [@fto-k](https://github.com/fto-k))*
- [`5e4f55d`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/5e4f55dcef5358c44a77eeb75624bc76db10242c) - cleaned up UIKit code *(commit by [@fto-k](https://github.com/fto-k))*


## [1.3.5] - 2024-02-23
### :sparkles: New Features
- [`9f34e68`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/9f34e68a9daaf4856d6939dea2ce6716b47e1f49) - exposing sk1Product *(commit by [@fto-k](https://github.com/fto-k))*


## [1.3.4] - 2024-01-22
### :bug: Bug Fixes
- [`1b9cd51`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/1b9cd518e1f4a2c07f68c1a3ab2784136468ad91) - small refactor from syncPurchase to syncPurchases *(commit by [@fto-k](https://github.com/fto-k))*
- [`848c4bd`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/848c4bd8fb0abf56fc620b35a8d1191afd3b2493) - possible fix for purchaseSubscription withId *(commit by [@fto-k](https://github.com/fto-k))*
- [`5ab7c4f`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/5ab7c4fcd3cfff6592f2d5250bbde356394481f9) - filtering all offerings *(commit by [@fto-k](https://github.com/fto-k))*


## [1.3.2] - 2024-01-12
### :bug: Bug Fixes
- [`275dfa4`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/275dfa494ebc7a4c70466e5634274ed9deaba0be) - syncPurchase() is now static *(commit by [@fto-k](https://github.com/fto-k))*

### :wrench: Chores
- [`753818f`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/753818f72b807c0f39f670e62320c6beb1ce94ac) - bumped podspec version *(commit by [@fto-k](https://github.com/fto-k))*


## [1.3.0] - 2024-01-09
### :sparkles: New Features
- [`c333514`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/c3335145fcad3509eb4d65db243bde533097dc06) - implemented new syncPurchase function and active property for EntitlementInfos *(commit by [@fto-k](https://github.com/fto-k))*

### :wrench: Chores
- [`ce080a8`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/ce080a8a82dec258b384f9765fd1984c29f555fa) - fixed podspec file *(commit by [@fto-k](https://github.com/fto-k))*


## [1.2.0] - 2023-11-13
### :sparkles: New Features
- [`147f5d3`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/147f5d3742efc076f3d2aec59b7c0f2a586a00dc) - improved Offering data structure to provide also metadata *(commit by [@fto-k](https://github.com/fto-k))*
- [`2b6ee72`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/2b6ee72ca160183ed44aedaac6e3f1e7bf38c22f) - added product price per month and checkTrialOrIntroDiscountEligibility function *(commit by [@fto-k](https://github.com/fto-k))*
- [`fe734b3`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/fe734b3681bb1317443f382f184518e4809633d3) - added new PurchaseDelegate *(commit by [@fto-k](https://github.com/fto-k))*
- [`d5efd02`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/d5efd02e646e16f5a968f5395f6a04ba5863d2d2) - set pricePerMonth / pricePerYear to public *(commit by [@fto-k](https://github.com/fto-k))*

### :bug: Bug Fixes
- [`05546e7`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/05546e7263ac1aefb9b2f583e19bd24cfd6eb853) - reverted package.swift *(commit by [@fto-k](https://github.com/fto-k))*


## [1.1.5] - 2023-10-30
### :recycle: Refactors
- [`83a3355`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/83a3355ef817c26e4da35be9e956f76c75ba1795) - updated purchase function used by ReactNatvie wrapper *(commit by [@fto-k](https://github.com/fto-k))*


## [1.1.4] - 2023-10-03
### :bug: Bug Fixes
- [`b69999b`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/b69999b6830b3033e890730f5a454c692b538a0b) - fixed minium dependency from KovaleeSDK *(commit by [@fto-k](https://github.com/fto-k))*
- [`223c7cc`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/223c7ccbb3c9156648b98138a373bfa85c953169) - fixed podfile name in fastlane *(commit by [@fto-k](https://github.com/fto-k))*


## [1.1.3] - 2023-09-20
### :sparkles: New Features
- [`0c4a914`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/0c4a914a8b9846c13ffcac4f4fd2bd45c1e9cd0c) - changed duration input param for purchaseSubscription from Int to Duration enum *(commit by [@fto-k](https://github.com/fto-k))*


## [1.1.2] - 2023-09-07
### :sparkles: New Features
- [`bcf8ad6`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/bcf8ad6d0fc0237381c9d9dc2796dfd47d939584) - implemented new functions for purchasing subscriptions by providing the id *(commit by [@fto-k](https://github.com/fto-k))*


## [1.1.1] - 2023-09-07
### :sparkles: New Features
- [`d837d7f`](https://github.com/cotyapps/KovaleePurchases-iOS/commit/d837d7fb38c931013a9d42a8c45ac400bcbd920f) - StoreDataModel entities are now conforming to Encodable *(commit by [@fto-k](https://github.com/fto-k))*


[1.1.1]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.1.0...1.1.1
[1.1.2]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.1.1...1.1.2
[1.1.3]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.1.2...1.1.3
[1.1.4]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.1.3...1.1.4
[1.1.5]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.1.4...1.1.5
[1.2.0]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.1.5...1.2.0
[1.3.0]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.2.1...1.3.0
[1.3.2]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.3.1...1.3.2
[1.3.4]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.3.3...1.3.4
[1.3.5]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.3.4...1.3.5
[1.4.0]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.3.5...1.4.0
[1.5.1]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.5.0...1.5.1
[1.5.2]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.5.1...1.5.2
[1.5.3]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.5.2...1.5.3
[1.5.4]: https://github.com/cotyapps/KovaleePurchases-iOS/compare/1.5.3...1.5.4