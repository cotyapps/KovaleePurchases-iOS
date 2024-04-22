import Foundation
import KovaleeFramework
import KovaleeSDK

extension PurchaseManagerCreator: Creator {
    public func createImplementation(
        withConfiguration _: Configuration,
        andKeys keys: KovaleeKeys
    ) -> Manager {
        guard let key = keys.revenueCat else {
            fatalError("No configuration Key for RevenueCat found in the Keys file")
        }

        return RevenueCatWrapperImpl(withKeys: key)
    }
}

// MARK: Revenue Cat Purchases

public extension Kovalee {
    /// Set a specific userId for RevenueCat
    ///
    /// - Parameters:
    ///    - userId: a string representing the userId to be set
    static func setRevenueCatUserId(userId: String) {
        shared.kovaleeManager?.setRevenueCatUserId(userId: userId)
    }

    /// Retrieve the ``CustomerInfo`` for the current customer
    ///
    /// - Returns: current customer information
    static func customerInfo() async throws -> CustomerInfo? {
        try await shared.kovaleeManager?.customerInfo() as? CustomerInfo
    }

    /// Retrieve the ``CustomerInfo`` for the current customer
    ///
    /// - Parameters:
    ///    - completion: current customer information if returned.
    static func customerInfo(withCompletion completion: @escaping (CustomerInfo?) -> Void) throws {
        Task {
            try completion(await Self.customerInfo())
        }
    }

    /// Sync the purchases for the current customer
    ///
    /// - Returns: current customer information
    static func syncPurchases() async throws -> CustomerInfo? {
        try await shared.kovaleeManager?.syncPurchase() as? CustomerInfo
    }

    /// Sync the purchases for the current customer
    ///
    /// - Parameters:
    ///    - completion: current customer information
    static func syncPurchases(withCompletion completion: @escaping (CustomerInfo?) -> Void) throws {
        Task {
            try completion(await Self.syncPurchases())
        }
    }

    /// Fetch ``Offerings`` if available
    ///
    /// - Returns: available offerings
    static func fetchOfferings() async throws -> Offerings? {
        try await shared.kovaleeManager?.fetchOfferings() as? Offerings
    }

    /// Fetch ``Offerings`` if available
    ///
    /// - Parameters:
    ///    - completion: available offerings
    static func fetchOfferings(withCompletion completion: @escaping (Offerings?) -> Void) throws {
        Task {
            try completion(await Self.fetchOfferings())
        }
    }

    /// Fetch current ``Offering`` if available
    ///
    /// - Returns: available current offering
    static func fetchCurrentOffering() async throws -> Offering? {
        try await shared.kovaleeManager?.fetchCurrentOffering() as? Offering
    }

    /// Fetch current ``Offering`` if available
    ///
    /// - Parameters:
    ///    - completion: available offering
    static func fetchCurrentOffering(withCompletion completion: @escaping (Offering?) -> Void) throws {
        Task {
            try completion(await Self.fetchCurrentOffering())
        }
    }

    /// Restore purchase previously made by current user
    ///
    /// - Parameters:
    ///    - fromSource: from where is the user making the purchase
    /// - Returns: current ``CustomerInfo``
    static func restorePurchases(fromSource source: String) async throws -> CustomerInfo? {
        try await shared.kovaleeManager?.restorePurchases(fromSource: source) as? CustomerInfo
    }

    /// Restore purchase previously made by current user
    ///
    /// - Parameters:
    ///    - fromSource: from where is the user making the purchase
    ///    - completion: current ``CustomerInfo``
    static func restorePurchases(
        fromSource source: String,
        withCompletion completion: @escaping (CustomerInfo?) -> Void
    ) throws {
        Task {
            try completion(await Self.restorePurchases(fromSource: source))
        }
    }

    /// Performs a purchase fo the specified ``Package``
    ///
    /// - Parameters:
    ///    - package: the package to be purchased
    ///    - fromSource: from where is the user making the purchase
    /// - Returns: the result of the purchase transaction as ``PurchaseResultData``
    static func purchase(package: Package, fromSource source: String) async throws -> PurchaseResultData? {
        try await shared.kovaleeManager?.purchase(package: package, fromSource: source) as? PurchaseResultData
    }

    /// Performs a purchase of the specified ``Package``
    ///
    /// - Parameters:
    ///    - package: the package to be purchased
    ///    - fromSource: from where is the user making the purchase
    ///    - completion: the result of the purchase transaction as ``PurchaseResultData``
    static func purchase(
        package: Package,
        fromSource source: String,
        withCompletion completion: @escaping (PurchaseResultData?) -> Void
    ) throws {
        Task {
            try completion(await Self.purchase(package: package, fromSource: source))
        }
    }

    /// Performs a purchase of a subscription with specified Id and duration
    ///
    /// - Parameters:
    ///    - subscriptionId: the id of the product to be purchased
    ///    - fromSource: from where is the user making the purchase
    /// - Returns: the result of the purchase transaction as ``PurchaseResultData``
    static func purchaseSubscription(
        withId subscriptionId: String,
        fromSource source: String
    ) async throws -> PurchaseResultData? {
        guard
            let offerings = try await shared.kovaleeManager?.fetchOfferings() as? Offerings,
            let package = offerings.returnOffering(withSubscriptionId: subscriptionId)
        else {
            return nil
        }

        return try await Self.shared.kovaleeManager?.purchase(package: package, fromSource: source) as? PurchaseResultData
    }

    /// Performs a purchase of a subscription with specified Id and duration
    ///
    /// - Parameters:
    ///    - subscriptionId: the id of the product to be purchased
    ///    - fromSource: from where is the user making the purchase
    ///    - completion: the result of the purchase transaction as ``PurchaseResultData``
    static func purchaseSubscription(
        withId subscriptionId: String,
        fromSource source: String,
        withCompletion completion: @escaping (PurchaseResultData?) -> Void
    ) throws {
        Task {
            try completion(await Self.purchaseSubscription(withId: subscriptionId, fromSource: source))
        }
    }

    static func revenueCatUserId() -> String {
        shared.kovaleeManager?.revenueCatUserId() ?? ""
    }

    static func checkTrialOrIntroDiscountEligibility(productIdentifiers: [String]) async -> [String: IntroEligibilityStatus] {
        await shared.kovaleeManager?
            .checkTrialOrIntroDiscountEligibility(productIdentifiers: productIdentifiers)?
            .compactMapValues { IntroEligibilityStatus(rawValue: $0) } ?? [:]
    }

    static func checkTrialOrIntroDiscountEligibility(
        productIdentifiers: [String],
        withCompletion completion: @escaping ([String: IntroEligibilityStatus]) -> Void
    ) async {
        Task {
            completion(await Self.checkTrialOrIntroDiscountEligibility(productIdentifiers: productIdentifiers))
        }
    }

    static func setPurchasesDelegate(_ delegate: KovaleePurchasesDelegate) {
        shared.kovaleeManager?.setPurchaseDelegate(delegate)
    }
}
