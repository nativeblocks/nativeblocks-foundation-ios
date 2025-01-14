import Nativeblocks
import SwiftUI

@available(macOS 13.3,iOS 16.0, *)
class ScrollIndicatorVisibilityNativeType: INativeType<ScrollIndicatorVisibility> {
    let defaultString = "automatic"
    let dafault: ScrollIndicatorVisibility = .automatic

    override required init() {
        super.init()
    }

    override func toString(_ input: ScrollIndicatorVisibility?) -> String {
        guard let input = input else { return defaultString }
            switch input {
            case .automatic:
                return "automatic"
            case .hidden:
                return "hidden"
            case .never:
                return "never"
            case .visible:
                return "visible"
            default:
                return defaultString
            }
    }

    override func fromString(_ input: String?) -> ScrollIndicatorVisibility {
        guard let input = input else { return dafault }
        switch input.lowercased() {
        case "automatic":
            return .automatic
        case "hidden":
            return .hidden
        case "never":
            return .never
        case "visible":
            return .visible
        default:
            return dafault
        }
    }
}
