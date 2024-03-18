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
                self.paywallViewController = await SuperwallPaywallHandler.retrievePaywall(
                    event: event,
                    source: source,
                    params: params,
                    paywallDelegate: paywallDelegate
                )
            }
            Kovalee.sendEvent(event: .pageView(screen: source))
        }
    }
}
