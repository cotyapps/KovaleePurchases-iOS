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
        Self.shared.kovaleeManager?.setRevenueCatUserId(userId: userId)
    }

    /// Retrieve the ``CustomerInfo`` for the current customer
    ///
    /// - Returns: current customer information
    static func customerInfo() async throws -> CustomerInfo? {
        try await Self.shared.kovaleeManager?.customerInfo() as? CustomerInfo
    }

    /// Sync the purchases for the current customer
    ///
    /// - Returns: current customer information
    static func syncPurchases() async throws -> CustomerInfo? {
        try await Self.shared.kovaleeManager?.syncPurchase() as? CustomerInfo
    }

    /// Fetch ``Offerings`` if available
    ///
    /// - Returns: available offerings
    static func fetchOfferings() async throws -> Offerings? {
        try await Self.shared.kovaleeManager?.fetchOfferings() as? Offerings
    }

    /// Fetch current ``Offering`` if available
    ///
    /// - Returns: available current offering
    static func fetchCurrentOffering() async throws -> Offering? {
        try await Self.shared.kovaleeManager?.fetchCurrentOffering() as? Offering
    }

    /// Restore purchase previously made by current user
    ///
    /// - Parameters:
    ///    - fromSource: from where is the user making the purchase
    /// - Returns: current ``CustomerInfo``
    static func restorePurchases(fromSource source: String) async throws -> CustomerInfo? {
        try await Self.shared.kovaleeManager?.restorePurchases(fromSource: source) as? CustomerInfo
    }

    /// Performs a purchase fo the specified ``Package``
    ///
    /// - Parameters:
    ///    - package: the package to be purchased
    ///    - fromSource: from where is the user making the purchase
    /// - Returns: the result of the purchase transation as ``PurchaseResultData``
    static func purchase(package: Package, fromSource source: String) async throws -> PurchaseResultData? {
        try await Self.shared.kovaleeManager?.purchase(package: package, fromSource: source) as? PurchaseResultData
    }

    /// Performs a purchase of a subscriptoin with specified Id and duration
    ///
    /// - Parameters:
    ///    - subscriptionId: the id of the product to be purchased
    ///    - fromSource: from where is the user making the purchase
    /// - Returns: the result of the purchase transation as ``PurchaseResultData``
    static func purchaseSubscription(
        withId subscriptionId: String,
        fromSource source: String
    ) async throws -> PurchaseResultData? {
        guard
            let offerings = try await Self.shared.kovaleeManager?.fetchOfferings() as? Offerings,
            let package = offerings.returnOffering(withSubscriptionId: subscriptionId)
        else {
            return nil
        }

        return try await Self.shared.kovaleeManager?.purchase(package: package, fromSource: source) as? PurchaseResultData
    }

    static func revenueCatUserId() -> String {
        Self.shared.kovaleeManager?.revenueCatUserId() ?? ""
    }

    static func checkTrialOrIntroDiscountEligibility(productIdentifiers: [String]) async -> [String: IntroEligibilityStatus] {
        await Self.shared.kovaleeManager?
            .checkTrialOrIntroDiscountEligibility(productIdentifiers: productIdentifiers)?
            .compactMapValues { IntroEligibilityStatus(rawValue: $0) } ?? [:]
    }

    static func setPurchasesDelegate(_ delegate: KovaleePurchasesDelegate) {
        Self.shared.kovaleeManager?.setPurchaseDelegate(delegate)
    }
}
