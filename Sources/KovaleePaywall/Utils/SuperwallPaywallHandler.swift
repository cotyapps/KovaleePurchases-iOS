import KovaleeFramework
import KovaleeSDK
import SuperwallKit

class SuperwallPaywallHandler {
    private var onComplete: (PaywallPresentationError?) -> Void

    init(onComplete: @escaping (PaywallPresentationError?) -> Void) {
        self.onComplete = onComplete
    }

    func retrievePaywall(
        event: String,
        params: [String: Any]?
    ) async -> PaywallViewController? {
        do {
            return try await getPaywall(event: event, params: params)
        } catch {
            KLogger.error("❌ 💸 Paywall not loaded with error: \(error)")
            if error is PaywallSkippedReason {
                onComplete(PaywallPresentationError.mapFromSuperwall(reason: error as! PaywallSkippedReason))
            } else {
                onComplete(.unknownError)
            }
            return nil
        }
    }

    private func getPaywall(
        event: String,
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

        onComplete(nil)
    }
}
