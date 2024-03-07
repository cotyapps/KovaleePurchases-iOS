import KovaleeFramework
import KovaleePurchases
import KovaleeRemoteConfig
import KovaleeSDK
import SuperwallKit
import SwiftUI

struct PaywallViewControllerWrapper: UIViewControllerRepresentable {
    let viewController: PaywallViewController

    func makeUIViewController(context _: Context) -> some UIViewController {
        return viewController
    }

    func updateUIViewController(_: UIViewControllerType, context _: Context) {}
}

class PaywallDelegate {
    var onComplete: () -> Void

    init(onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
    }
}

extension PaywallDelegate: PaywallViewControllerDelegate {
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

struct SuperwallPaywallView: View {
    let paywallDelegate: PaywallDelegate
    let event: String
    let params: [String: Any]?
    let source: String

    @State private var paywallViewController: PaywallViewController?

    var body: some View {
        Group {
            if let viewController = paywallViewController {
                PaywallViewControllerWrapper(viewController: viewController)
                    .ignoresSafeArea(edges: .all)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            Task {
                self.paywallViewController = await retrievePaywall()
            }
            Kovalee.sendEvent(event: .paywallView(source))
        }
    }
}

extension SuperwallPaywallView {
    private func retrievePaywall() async -> PaywallViewController? {
        do {
            let paywallController = try await loadPaywall()
            await Kovalee.handlePaywallABTest(withVariant: paywallController.info.name)

            return paywallController
        } catch {
            KLogger.error("❌ 💸 Paywall not loaded with error: \(error)")
            paywallDelegate.onComplete()
            return nil
        }
    }

    private func loadPaywall() async throws -> PaywallViewController {
        do {
            let paywallEvent = await Kovalee.getEventFromABTest() ?? event
            return try await Superwall.shared.getPaywall(
                forEvent: paywallEvent,
                params: params,
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
