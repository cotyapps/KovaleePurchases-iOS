import SuperwallKit
import SwiftUI

struct PaywallViewControllerWrapper: UIViewControllerRepresentable {
    let viewController: PaywallViewController

    func makeUIViewController(context _: Context) -> some UIViewController {
        return viewController
    }

    func updateUIViewController(_: UIViewControllerType, context _: Context) {}
}

struct SuperwallPaywallView<Paywall: View>: View {
    let event: String
    let params: [String: Any]?

    var alternativePaywall: AlternativePaywall<Paywall>

    enum ViewState {
        case loading
        case paywall(PaywallViewController)
        case alternativePaywall
    }

    init(
        event: String,
        params: [String: Any]?,
        alternativePaywall: AlternativePaywall<Paywall>,
        onComplete: @escaping (PaywallPresentationError?) -> Void
    ) {
        self.event = event
        self.params = params
        self.alternativePaywall = alternativePaywall
        paywallHandler = SuperwallPaywallHandler(onComplete: onComplete)
    }

    private var paywallHandler: SuperwallPaywallHandler
    @State private var viewState: ViewState = .loading

    var body: some View {
        Group {
            switch viewState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity)
            case let .paywall(paywall):
                PaywallViewControllerWrapper(viewController: paywall)
                    .ignoresSafeArea(edges: .all)
            case .alternativePaywall:
                alternativePaywall
            }
        }
        .onAppear {
            Task {
                if let paywall = await paywallHandler.retrievePaywall(
                    event: event, params: params
                ) {
                    viewState = .paywall(paywall)
                } else {
                    viewState = .alternativePaywall
                }
            }
        }
    }
}
