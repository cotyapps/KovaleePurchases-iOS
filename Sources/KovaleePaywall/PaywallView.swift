import SuperwallKit
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
public struct PaywallView<AlternativePaywall: View>: View {
    @AppStorage(.paywallSource) private var paywallSource = ""

    private let trigger: String
    private let source: String
    private let params: [String: Any]?
    private let alternativePaywall: AlternativePaywall
    private var onComplete: (PaywallPresentationError?) -> Void

    /// Creates a `PaywallView` instance.
    ///
    /// - Parameters:
    ///   - trigger: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - alternativePaywall: View to be presented in case the designated paywall can't be presented
    ///   - onComplete: A closure called upon the completion of the paywall interaction. It will return an optional presentation error in case of issues presenting the designated paywall.
    public init(
        trigger: String,
        source: String,
        params: [String: Any]? = nil,
        @ViewBuilder alternativePaywall: () -> AlternativePaywall,
        onComplete: @escaping (PaywallPresentationError?) -> Void
    ) {
        self.trigger = trigger
        self.source = source
        self.params = params
        self.onComplete = onComplete
        self.alternativePaywall = alternativePaywall()
    }

    /// Creates a `PaywallView` instance.
    ///
    /// - Parameters:
    ///   - trigger: The event trigger for showing the paywall. It refers to the event_name in Superwall.
    ///   - source: The source from where the paywall has been triggered (ie.  onboarding, home, user profiel etc...). This is useful for tracking purposes.
    ///   - params: Optional parameters to send to Superwall for filtering audiences.
    ///   - onComplete: A closure called upon the completion of the paywall interaction. It will return an optional presentation error in case of issues presenting the designated paywall.
    public init(
        trigger: String,
        source: String,
        params: [String: Any]? = nil,
        onComplete: @escaping (PaywallPresentationError?) -> Void
    ) where AlternativePaywall == EmptyView {
        self.trigger = trigger
        self.source = source
        self.params = params
        self.onComplete = onComplete
        alternativePaywall = EmptyView()
    }

    public var body: some View {
        SuperwallPaywallView(
            event: trigger,
            params: params,
            source: source,
            alternativePaywall: alternativePaywall,
            onComplete: onComplete
        )
        .onAppear {
            paywallSource = source
        }
    }
}

public enum PaywallPresentationError {
    /// The user was assigned to a holdout.
    ///
    /// A holdout is a control group which you can analyse against
    /// who don't receive any paywall when they match a rule.
    case holdout

    /// No rule was matched for this event.
    case noRuleMatch

    /// This event was not found on the dashboard.
    case eventNotFound

    /// The user is subscribed.
    case userIsSubscribed

    case unknownError
}

extension PaywallPresentationError {
    static func mapFromSuperwall(reason: PaywallSkippedReason) -> Self {
        switch reason {
        case .holdout:
            .holdout
        case .noRuleMatch:
            .noRuleMatch
        case .eventNotFound:
            .eventNotFound
        case .userIsSubscribed:
            .userIsSubscribed
        }
    }
}
