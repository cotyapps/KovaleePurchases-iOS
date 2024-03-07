import SwiftUI

public extension View {
    func fullScreenPaywall(
        isPresented: Binding<Bool>,
        trigger: String,
        source: String,
        params: [String: Any]? = nil,
        onComplete: (() -> Void)? = nil
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            PaywallView(trigger: trigger, source: source, params: params) {
                isPresented.wrappedValue.toggle()
                onComplete?()
            }
        }
    }
}
