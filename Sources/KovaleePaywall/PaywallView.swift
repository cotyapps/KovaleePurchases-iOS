import SwiftUI

// MARK: Kovalee Paywall

/// `PaywallView` is a SwiftUI view that presents a paywall configured in Superwall.
///
/// This view is used to show a paywall based on various triggers and parameters.
/// It utilizes `Superwall` for the actual presentation and handles the completion event through a provided closure.
///
/// ## Topics
///
/// ### Initializing a Paywall View
/// - ``PaywallView/init(trigger:source:params:onComplete:)``
///
/// ## Example
///
/// ```swift
/// PaywallView(
///     trigger: "user_trial_ended",
///     source: "onboarding",
///     params: ["user_id": "12345"],
///     onComplete: {
///         isPresented = false
///     }
/// )
/// ```
public struct PaywallView: View {
    @AppStorage(.paywallSource) private var paywallSource = ""

    private let trigger: String
    private let source: String
    private let params: [String: Any]?
    private var onComplete: () -> Void

    /// Creates a `PaywallView` instance.
    ///
    /// - Parameters:
    ///   - trigger: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - onComplete: A closure called upon the completion of the paywall interaction.
    public init(
        trigger: String,
        source: String,
        params: [String: Any]? = nil,
        onComplete: @escaping () -> Void
    ) {
        self.trigger = trigger
        self.source = source
        self.params = params
        self.onComplete = onComplete
    }

    private var paywallDelegate: PaywallDelegate {
        PaywallDelegate {
            onComplete()
        }
    }

    public var body: some View {
        SuperwallPaywallView(
            paywallDelegate: paywallDelegate,
            event: trigger,
            params: params,
            source: source
        )
        .onAppear {
            paywallSource = source
        }
    }
}
