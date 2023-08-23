import Foundation
import KovaleeFramework
import KovaleeSDK

extension PurchaseManagerCreator: Creator {
	public func createImplementation(
		withConfiguration configuration: Configuration,
		andKeys keys: KovaleeKeys
	) -> Manager {
		guard let key = keys.revenueCat else {
			fatalError("No configuration Key for RevenueCat found in the Keys file")
		}

		return RevenueCatWrapperImpl(withKeys: key)
	}
}

// MARK: Revenue Cat Purchases
extension Kovalee {
	/// Set a specific userId for RevenueCat
	///
	/// - Parameters:
	///    - userId: a string representing the userId to be set
	public static func setRevenueCatUserId(userId: String) {
		Self.shared.kovaleeManager?.setRevenueCatUserId(userId: userId)
	}

	/// Retrieve the ``CustomerInfo`` for the current customer
	///
	/// - Returns: current customer information
	public static func customerInfo() async throws -> CustomerInfo? {
		try await Self.shared.kovaleeManager?.customerInfo() as? CustomerInfo
	}

	/// Fetch ``Offerings`` if available
	///
	/// - Returns: available offerings
	public static func fetchOfferings() async throws -> Offerings? {
		try await Self.shared.kovaleeManager?.fetchOfferings() as? Offerings
	}

	/// Fetch current ``Offering`` if available
	///
	/// - Returns: available current offering
	public static func fetchCurrentOffering() async throws -> Offering? {
		try await Self.shared.kovaleeManager?.fetchCurrentOffering() as? Offering
	}

	/// Restore purchase previously made by current user
	///
	/// - Parameters:
	///    - fromSource: from where is the user making the purchase
	/// - Returns: current ``CustomerInfo``
	public static func restorePurchases(fromSource source: String) async throws -> CustomerInfo? {
		try await Self.shared.kovaleeManager?.restorePurchases(fromSource: source) as? CustomerInfo
	}

	/// Performs a purchase fo the specified ``Package``
	///
	/// - Parameters:
	///    - package: the package to be purchased
	///    - fromSource: from where is the user making the purchase
	/// - Returns: the result of the purchase transation as ``PurchaseResultData``
	public static func purchase(package: Package, fromSource source: String) async throws -> PurchaseResultData? {
		try await Self.shared.kovaleeManager?.purchase(package: package, fromSource: source) as? PurchaseResultData
	}
}
