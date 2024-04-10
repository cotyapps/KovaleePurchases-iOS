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

struct SuperwallPaywallView: View {
    let event: String
    let params: [String: Any]?
    let source: String

    init(event: String, params: [String: Any]?, source: String, onComplete: @escaping () -> Void) {
        self.event = event
        self.params = params
        self.source = source
        paywallHandler = SuperwallPaywallHandler(onComplete: onComplete)
    }

    private var paywallHandler: SuperwallPaywallHandler
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
                self.paywallViewController = await paywallHandler.retrievePaywall(
                    event: event,
                    source: source,
                    params: params
                )
            }
            Kovalee.sendEvent(event: BasicEvent.pageViewPaywall(source: source))
        }
    }
}
