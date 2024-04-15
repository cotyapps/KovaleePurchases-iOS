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
///			event: "button_click",
///			source: "onboarding"
///			params: ["user_id": "12345"],
///			alternativePaywall: AlternativePaywallViewController(variant: "0002")
///		) { vc, error in
///			vc.dismiss(animated: true)
///		}
/// present(paywallViewController, animated: true, completion: nil)
/// ```
public class KPaywallViewController: UIViewController {
    private var spinner: UIActivityIndicatorView?

    private let event: String
    private let params: [String: Any]?
    private let source: String

    private var alternativePaywall: AlternativePaywallController?
    private var onComplete: (UIViewController, PaywallPresentationError?) -> Void
    private lazy var paywallHandler = SuperwallPaywallHandler { [weak self] error in
        Task { @MainActor in
            guard let self else {
                return
            }

            if let error {
                if self.alternativePaywall == nil {
                    self.onComplete(self, error)
                }
            } else {
                self.onComplete(self, nil)
            }
        }
    }

    /// Creates a `KPaywallViewController` instance.
    ///
    /// - Parameters:
    ///   - event: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - alternativePaywall: Optional View Controller to be displayed in case the designated paywall can't be presented.
    ///   - onComplete: A closure called upon the completion of the paywall interaction. Returns the current ViewController so it can be dismissed and an optional presentation error in case of issues displaying the designated paywall.
    public init(
        event: String,
        source: String,
        params: [String: Any]?,
        alternativePaywall: AlternativePaywallController? = nil,
        onComplete: @escaping (UIViewController, PaywallPresentationError?) -> Void
    ) {
        self.event = event
        self.params = params
        self.source = source
        self.onComplete = onComplete
        self.alternativePaywall = alternativePaywall

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
            } else if let alternativePaywall = self.alternativePaywall {
                hideLoadingView()
                presentPaywallView(alternativePaywall)

                await Kovalee.handlePaywallABTest(withVariant: alternativePaywall.variant)
            }
        }
    }

    private func loadPaywallView() async -> PaywallViewController? {
        await paywallHandler.retrievePaywall(
            event: event,
            source: source,
            params: params
        )
    }

    private func presentPaywallView(_ viewController: UIViewController) {
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

/// A protocol that defines the requirements for a view controller to act as an `AlternativePaywallController`.
///
/// Conform to the `AlternativePaywallController` protocol in any `UIViewController` that is intended to manage
/// a paywall in your application. This protocol ensures that each paywall controller has a `variant` property,
/// which can be used for identifying and differentiating multiple paywall variations.
///
public protocol AlternativePaywallController: UIViewController {
    var variant: String { get }
}
