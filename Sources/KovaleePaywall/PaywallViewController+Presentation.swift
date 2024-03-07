import UIKit

/// An extension on `UIViewController` to present a full-screen paywall view controller.
///
/// This function presents a `KPaywallViewController` as a full-screen modal view. It initializes the paywall with necessary parameters such as the trigger event, source, and additional parameters. It also handles the completion of the paywall interaction.
///
/// Use this extension to easily present a paywall from any view controller in a full-screen format with the specified configuration.
///
/// ```swift
/// class ExampleViewController: UIViewController {
///     func showPaywall() {
///         presentFullScreenPaywallViewController(
///             trigger: "user_trial_ended",
///             source: "example_screen",
///             params: ["user_id": "12345"],
///             onComplete: {
///                 print("Paywall dismissed")
///             }
///         )
///     }
/// }
/// ```
public extension UIViewController {
    /// Presents a full screen paywall on top of the current view controller.
    ///
    /// This method creates an instance of `KPaywallViewController`, configures it with provided parameters, and presents it in full-screen mode.
    /// Upon completion of the paywall interaction, it dismisses the paywall and executes the `onComplete` closure, if provided.
    ///
    /// - Parameters:
    ///   - event: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - onComplete: An optional closure called after the paywall has been dismissed.
    func presentFullScreenPaywallViewController(
        trigger: String,
        source: String,
        params: [String: Any]? = nil,
        onComplete: (() -> Void)? = nil
    ) {
        let paywallViewController = KPaywallViewController(
            event: trigger,
            source: source,
            params: params
        ) { vc in
            vc.dismiss(animated: true)
            onComplete?()
        }

        paywallViewController.modalPresentationStyle = .fullScreen
        present(paywallViewController, animated: true, completion: nil)
    }
}
