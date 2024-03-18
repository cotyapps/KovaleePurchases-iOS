import KovaleeSDK
import SuperwallKit
import UIKit

/// ``KPaywallViewController`` is a UIViewController subclass that manages the presentation of a paywall in a full-screen format.
///
/// This controller is responsible for initializing with necessary parameters, presenting, and managing a Superwall `PaywallViewController`. It includes delegate handling for paywall completion events and supports modal presentation.
///
/// Use this view controller to present a paywall in response to various triggers, with additional custom parameters and completinion.

/// ```swift
/// let paywallViewController = KPaywallViewController(
///		event: "button_click",
///		source: "onboarding"
///		params: ["user_id": "12345"],
///		) { vc in
///			vc.dismiss(animated: true)
///		}
/// present(paywallViewController, animated: true, completion: nil)
/// ```
public class KPaywallViewController: UIViewController {
    private var spinner: UIActivityIndicatorView?

    private let event: String
    private let params: [String: Any]?
    private let source: String

    private var onComplete: (UIViewController) -> Void
    private lazy var paywallDelegate = PaywallDelegate { [weak self] in
        guard let self else { return }
        self.onComplete(self)
    }

    /// Creates a `KPaywallViewController` instance.
    ///
    /// - Parameters:
    ///   - event: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - onComplete: A closure called upon the completion of the paywall interaction. Returns the current ViewController so it can be dismissed.
    public init(
        event: String,
        source: String,
        params: [String: Any]?,
        onComplete: @escaping (UIViewController) -> Void
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

    override public func viewDidLoad() {
        super.viewDidLoad()

        Kovalee.sendEvent(event: .pageView(screen: source))
    }

    override public func viewWillAppear(_ animated: Bool) {
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
