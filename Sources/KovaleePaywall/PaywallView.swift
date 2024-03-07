import SwiftUI

public struct PaywallView: View {
    @AppStorage(.paywallSource) private var paywallSource = ""

    private let trigger: String
    private let source: String
    private let params: [String: Any]?
    private var onComplete: () -> Void

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
