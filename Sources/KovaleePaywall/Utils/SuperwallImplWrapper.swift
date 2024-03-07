import Foundation
import KovaleeFramework
import KovaleeSDK
import SuperwallKit

extension PaywallManagerCreator: Creator {
    public func createImplementation(
        withConfiguration configuration: Configuration,
        andKeys keys: KovaleeKeys
    ) -> Manager {
        guard let key = keys.superwall else {
            fatalError("No configuration Key for Superwall found in the Keys file")
        }

        let apiKey = configuration.environment == .production ?
            key.prodSDKId : (key.devSDKId ?? "")
        return SuperwallWrapperImpl(withApiKey: apiKey)
    }
}

extension Kovalee {
    /// Usefull in case of forcing AB tests variants for testing purposes
    static func paywallTriggerEventFromABTest() async -> String? {
        guard await experimentRunning() else {
            return nil
        }

        return await Kovalee.abTestValue()
    }

    /// Remember to set paywall_test_running in firebase otherwise data won't be recorded
    static func handlePaywallABTest(withVariant variant: String) async {
        guard await experimentRunning() else {
            return
        }

        Kovalee.setAbTestValue(variant)
    }

    private static func experimentRunning() async -> Bool {
        guard let value = await Kovalee.remoteValue(forKey: .paywallTestRunning) else {
            KLogger.debug("❌ 💸 Key paywall_test_running not found")
            return false
        }

        return value.boolValue ?? false
    }
}

class SuperwallWrapperImpl: NSObject, PaywallManager, Manager {
    init(withApiKey apiKey: String) {
        KLogger.debug("💸 Initializing Superwall")

        purchaseController = PurchaseManager()
        options = SuperwallOptions()
        self.apiKey = apiKey
        super.init()

        options.logging.level = KLogger.logLevel.superwallKitLogLevel()

        Superwall.configure(
            apiKey: self.apiKey,
            purchaseController: purchaseController,
            options: options
        )

        purchaseController.syncSubscriptionStatus()
    }

    func setDataCollectionEnabled(_ enabled: Bool) {
        options.isExternalDataCollectionEnabled = enabled
        Superwall.configure(
            apiKey: apiKey,
            purchaseController: purchaseController,
            options: options
        )
    }

    private let apiKey: String
    private let purchaseController: PurchaseManager
    private let options: SuperwallOptions
}

extension KovaleeFramework.LogLevel {
    func superwallKitLogLevel() -> SuperwallKit.LogLevel {
        switch self {
        case .verbose, .debug:
            SuperwallKit.LogLevel.debug
        case .info:
            SuperwallKit.LogLevel.info
        case .warn:
            SuperwallKit.LogLevel.warn
        case .error:
            SuperwallKit.LogLevel.error
        @unknown default:
            SuperwallKit.LogLevel.none
        }
    }
}
