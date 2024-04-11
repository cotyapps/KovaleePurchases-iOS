import SwiftUI

/// An extension on `View` to present a full-screen paywall.
///
/// This modifier attaches a full-screen paywall to the view. It utilizes the `PaywallView`
/// to present the actual paywall interface. The paywall appears as a full screen cover over
/// the current view context when the provided condition is met.
///
/// - Parameters:
///   - isPresented: A binding to a Boolean value that determines whether to present the paywall.
///   - trigger: The event trigger for showing the paywall. It refers to the event_name in Superwall.
///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
///   - params: Optional parameters to send to Superwall for filtering audiences.
///   - alternativePaywall: View To be presented in case the designated paywall can't be presented
///   - onComplete: An closure called when the paywall should been dismissed, you are in charge of dismissing it. It will return an error of type ``PaywallPresentationError`` in case of issues presenting the designated paywall.
///
/// ## Example
///
/// Use `fullScreenPaywall` to present a paywall from a view when a condition is met:
///
/// ```swift
/// struct ContentView: View {
///     @State private var showPaywall = false
///
///     var body: some View {
///         Button("Show Paywall") {
///             showPaywall = true
///         }
///         .fullScreenPaywall(
///             isPresented: $showPaywall,
///             trigger: "button_click",
///             source: "ContentView",
///             params: ["user_id": "12345"],
///             onComplete: { error in
///             	if let error {
///             		print("There was an error presenting the paywall")
///             	}
///                 print("Paywall dismissed")
///                 showPaywall = false
///             }
///         )
///     }
/// }
/// ```
public extension View {
    /// Adds a full screen paywall to the view.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean that determines whether to present the paywall.
    ///   - trigger: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - alternativePaywall: View To be presented in case the designated paywall can't be presented
    ///   - onComplete: An closure called when the paywall should been dismissed, you are in charge of dismissing it. It will return an error of type ``PaywallPresentationError`` in case of issues presenting the designated paywall.
    func fullScreenPaywall(
        isPresented: Binding<Bool>,
        trigger: String,
        source: String,
        params: [String: Any]? = nil,
        @ViewBuilder alternativePaywall: @escaping () -> some View,
        onComplete: @escaping ((PaywallPresentationError?) -> Void)
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            PaywallView(
                trigger: trigger,
                source: source,
                params: params,
                alternativePaywall: alternativePaywall,
                onComplete: onComplete
            )
        }
    }

    /// Adds a full screen paywall to the view.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean that determines whether to present the paywall.
    ///   - trigger: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - onComplete: An closure called when the paywall should been dismissed, you are in charge of dismissing it. It will return an error of type ``PaywallPresentationError`` in case of issues presenting the designated paywall.
    func fullScreenPaywall(
        isPresented: Binding<Bool>,
        trigger: String,
        source: String,
        params: [String: Any]? = nil,
        onComplete: @escaping ((PaywallPresentationError?) -> Void)
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            PaywallView(trigger: trigger, source: source, params: params, onComplete: onComplete)
        }
    }
}
