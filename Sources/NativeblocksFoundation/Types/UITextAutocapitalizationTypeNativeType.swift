import Nativeblocks
import SwiftUI

#if os(iOS)
    import UIKit

    class UITextAutocapitalizationTypeNativeType: INativeType<UITextAutocapitalizationType> {
        let defaultString = "none"
        let dafault: UITextAutocapitalizationType = .none

        override required init() {
            super.init()
        }

        override func toString(_ input: UITextAutocapitalizationType?) -> String {
            guard let input = input as? UITextAutocapitalizationType else { return defaultString }
            switch input {
            case .allCharacters:
                return "allcharacters"
            case .sentences:
                return "sentences"
            case .words:
                return "words"
            case .none:
                return "none"
            @unknown default:
                return defaultString
            }
        }

        override func fromString(_ input: String?) -> UITextAutocapitalizationType {
            guard let input = input else { return dafault }
            switch input.lowercased() {
            case "allcharacters":
                return UITextAutocapitalizationType.allCharacters
            case "sentences":
                return UITextAutocapitalizationType.sentences
            case "words":
                return UITextAutocapitalizationType.words
            case "none":
                return UITextAutocapitalizationType.none
            default:
                return dafault
            }
        }
    }
#endif
