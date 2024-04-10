import KovaleeFramework
import KovaleeSDK
import SuperwallKit

class SuperwallPaywallHandler {
    var onComplete: () -> Void

    init(onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
    }

    func retrievePaywall(
        event: String,
        source: String,
        params: [String: Any]?
    ) async -> PaywallViewController? {
        do {
            let paywallController = try await getPaywall(
                event: event,
                source: source,
                params: params
            )
            await Kovalee.handlePaywallABTest(withVariant: paywallController.info.name)

            return paywallController
        } catch {
            KLogger.error("❌ 💸 Paywall not loaded with error: \(error)")
            onComplete()
            return nil
        }
    }

    private func getPaywall(
        event: String,
        source _: String,
        params: [String: Any]?
    ) async throws -> PaywallViewController {
        do {
            let triggerEvent = await Kovalee.paywallTriggerEventFromABTest() ?? event
            var userParams = params ?? [String: Any]()
            userParams["event_name"] = triggerEvent
            return try await Superwall.shared.getPaywall(
                forEvent: triggerEvent,
                params: userParams,
                delegate: self
            )

            /// In case the event retrieved by the AB test has no paywalls associated
            /// retrieve the paywall associated to the default event
        } catch PaywallSkippedReason.eventNotFound {
            return try await Superwall.shared.getPaywall(
                forEvent: event,
                params: params,
                delegate: self
            )
        } catch {
            throw error
        }
    }
}

extension SuperwallPaywallHandler: PaywallViewControllerDelegate {
    func paywall(
        _: SuperwallKit.PaywallViewController,
        didFinishWith _: SuperwallKit.PaywallResult,
        shouldDismiss dismiss: Bool
    ) {
        guard dismiss else {
            return
        }

        onComplete()
    }
}
