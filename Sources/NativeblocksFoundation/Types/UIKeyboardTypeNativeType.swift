import Nativeblocks
import SwiftUI

#if os(iOS)
    import UIKit

    class UIKeyboardTypeNativeType: INativeType<UIKeyboardType> {
        let defaultString = "default"
        let dafault = UIKeyboardType.default

        override required init() {
            super.init()
        }

        override func toString(_ input: UIKeyboardType?) -> String {
            guard let input = input else { return defaultString }
            switch input {
            case .asciiCapable:
                return "asciicapable"
            case .numbersAndPunctuation:
                return "numbersandpunctuation"
            case .URL:
                return "url"
            case .numberPad:
                return "numberpad"
            case .phonePad:
                return "phonepad"
            case .namePhonePad:
                return "namephonepad"
            case .emailAddress:
                return "emailaddress"
            case .decimalPad:
                return "decimalpad"
            case .twitter:
                return "twitter"
            case .webSearch:
                return "websearch"
            case .asciiCapableNumberPad:
                return "asciicapablenumberpad"
            case .alphabet:
                return "alphabet"
            default:
                return defaultString
            }
        }

        override func fromString(_ input: String?) -> UIKeyboardType {
            guard let input = input else { return dafault }
            switch input.lowercased() {
            case "asciicapable":
                return .asciiCapable
            case "numbersandpunctuation":
                return .numbersAndPunctuation
            case "url":
                return .URL
            case "numberpad":
                return .numberPad
            case "phonepad":
                return .phonePad
            case "namephonepad":
                return .namePhonePad
            case "emailaddress":
                return .emailAddress
            case "decimalpad":
                return .decimalPad
            case "twitter":
                return .twitter
            case "websearch":
                return .webSearch
            case "asciicapablenumberpad":
                return .asciiCapableNumberPad
            case "alphabet":
                return .alphabet
            default:
                return dafault
            }
        }
    }

#endif
