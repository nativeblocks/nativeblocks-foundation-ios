import Nativeblocks
import SwiftUI

class ScrollIndicatorVisibilityNativeType: INativeType<ScrollIndicatorVisibility> {
    let defaultString = "automatic"
    let dafault: ScrollIndicatorVisibility = .automatic

    override required init() {
        super.init()
    }

    override func toString(_ input: ScrollIndicatorVisibility?) -> String {
        guard let input = input else { return defaultString }
        if #available(macOS 13.3, iOS 16.0, *) {
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
        } else {
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
