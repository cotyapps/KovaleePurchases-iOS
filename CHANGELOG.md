# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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