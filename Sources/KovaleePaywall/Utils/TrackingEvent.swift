import Foundation
import KovaleeSDK

enum TrackingEvent {
    case paywallView(String)

    var name: String {
        switch self {
        case .paywallView:
            "page_view_paywall"
        }
    }

    var properties: [String: Any]? {
        switch self {
        case let .paywallView(source):
            ["source": source]
        }
    }
}

extension Kovalee {
    static func sendEvent(event: TrackingEvent) {
        Self.sendEvent(withName: event.name, andProperties: event.properties)
    }
}
