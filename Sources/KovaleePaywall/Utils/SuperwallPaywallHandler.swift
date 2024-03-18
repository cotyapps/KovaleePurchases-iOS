import KovaleeFramework
import KovaleeSDK
import SuperwallKit

struct SuperwallPaywallHandler {
    static func retrievePaywall(
        event: String,
        source: String,
        params: [String: Any]?,
        paywallDelegate: PaywallDelegate
    ) async -> PaywallViewController? {
        do {
            let paywallController = try await Self.getPaywall(
                event: event,
                source: source,
                params: params,
                paywallDelegate: paywallDelegate
            )
            await Kovalee.handlePaywallABTest(withVariant: paywallController.info.name)

            return paywallController
        } catch {
            KLogger.error("❌ 💸 Paywall not loaded with error: \(error)")
            paywallDelegate.onComplete()
            return nil
        }
    }

    private static func getPaywall(
        event: String,
        source _: String,
        params: [String: Any]?,
        paywallDelegate: PaywallDelegate
    ) async throws -> PaywallViewController {
        do {
            let triggerEvent = await Kovalee.paywallTriggerEventFromABTest() ?? event
            var userParams = params ?? [String: Any]()
            userParams["event_name"] = triggerEvent
            return try await Superwall.shared.getPaywall(
                forEvent: triggerEvent,
                params: userParams,
                delegate: paywallDelegate
            )

            /// In case the event retrieved by the AB test has no paywalls associated
            /// retrieve the paywall associated to the default event
        } catch PaywallSkippedReason.eventNotFound {
            return try await Superwall.shared.getPaywall(
                forEvent: event,
                params: params,
                delegate: paywallDelegate
            )
        } catch {
            throw error
        }
    }
}
