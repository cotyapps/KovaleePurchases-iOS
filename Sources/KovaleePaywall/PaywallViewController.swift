import KovaleeSDK
import SuperwallKit
import UIKit

class KPaywallViewController: UIViewController {
    private var paywallDelegate: PaywallDelegate {
        PaywallDelegate {
            self.onComplete()
        }
    }

    private var spinner: UIActivityIndicatorView?

    private let event: String
    private let params: [String: Any]?
    private let source: String
    private var onComplete: () -> Void

    init(
        event: String,
        params: [String: Any]?,
        source: String,
        onComplete: @escaping () -> Void
    ) {
        self.event = event
        self.params = params
        self.source = source
        self.onComplete = onComplete
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Kovalee.sendEvent(event: .pageView(screen: source))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoadingView()

        Task { @MainActor in
            if let paywallViewController = await self.loadPaywallView() {
                hideLoadingView()
                presentPaywallView(paywallViewController)
            }
        }
    }

    private func loadPaywallView() async -> PaywallViewController? {
        await SuperwallPaywallHandler.retrievePaywall(
            event: event,
            source: source,
            params: params,
            paywallDelegate: paywallDelegate
        )
    }

    private func presentPaywallView(_ viewController: PaywallViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.view.frame = view.bounds
    }

    private func showLoadingView() {
        spinner = UIActivityIndicatorView(style: .large)
        spinner?.translatesAutoresizingMaskIntoConstraints = false
        spinner?.startAnimating()
        view.addSubview(spinner!)

        NSLayoutConstraint.activate([
            spinner!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        view.isUserInteractionEnabled = false
    }

    private func hideLoadingView() {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()

        // Re-enable user interaction
        view.isUserInteractionEnabled = true
    }
}
