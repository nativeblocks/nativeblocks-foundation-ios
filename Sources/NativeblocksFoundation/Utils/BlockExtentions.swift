import Foundation
import Nativeblocks
import SwiftUI

extension String {
    /// Checks if the string is a valid URL for an image.
    /// - Returns: `true` if the URL is valid, otherwise `false`.
    public func isValidImageUrl() -> Bool {
        guard let url = URL(string: self) else { return false }
        guard url.scheme == "http" || url.scheme == "https" else { return false }

        #if os(iOS)
            return UIApplication.shared.canOpenURL(url)
        #else
            return true
        #endif
    }
}

extension View {
    /// Applies a width and height modifier to a view.
    /// - Parameters:
    ///   - width: The width string (e.g., "infinity" or a numeric value).
    ///   - height: The height string (e.g., "infinity" or a numeric value).
    ///   - alignment: The alignment for the view's frame.
    /// - Returns: A view with the specified frame settings.
    public func blockWidthAndHeightModifier(_ width: String, _ height: String, alignment: Alignment = .center) -> some View {
        var maxWidth: CGFloat? = nil
        var maxHeight: CGFloat? = nil

        switch width.lowercased() {
        case "infinity":
            maxWidth = .infinity
        default:
            if let widthValue = Double(width) {
                maxWidth = CGFloat(widthValue)
            }
        }

        switch height.lowercased() {
        case "infinity":
            maxHeight = .infinity
        default:
            if let heightValue = Double(height) {
                maxHeight = CGFloat(heightValue)
            }
        }

        return self.frame(
            minWidth: (maxWidth != nil && maxWidth != .infinity) ? maxWidth : nil,
            maxWidth: maxWidth,
            minHeight: (maxHeight != nil && maxHeight != .infinity) ? maxHeight : nil,
            maxHeight: maxHeight,
            alignment: alignment
        )
    }

    public func blockFont(family: String, size: CGFloat, weight: Font.Weight, design: Font.Design) -> some View {
        var font: Font? = nil
        let fontWeight = weight
        let fontDesign = design
        switch family.lowercased() {
        case "system":
            font = .system(size: size, weight: fontWeight, design: fontDesign)
        default:
            font = .custom(family, size: size)
        }
        return self.font(font)
    }
}

/// Creates a rounded rectangle shape with the specified corner radius.
/// - Parameter radius: The corner radius of the rounded rectangle.
/// - Returns: A `RoundedRectangle` with the specified corner radius.
public func roundedRectangleShape(
    _ radius: CGFloat
) -> RoundedRectangle {
    return RoundedRectangle(cornerRadius: radius)
}

extension View {
    /// Sets the keyboard type for text input fields within the view's environment.
    /// - Parameter type: A string representing the keyboard type (e.g., "asciicapable", "numberpad").
    /// - Returns: A view with the specified keyboard type applied.
    ///
    /// Supported keyboard types:
    /// - "asciicapable"
    /// - "numbersandpunctuation"
    /// - "url"
    /// - "numberpad"
    /// - "phonepad"
    /// - "namephonepad"
    /// - "emailaddress"
    /// - "decimalpad"
    /// - "twitter"
    /// - "websearch"
    /// - "asciicapablenumberpad"
    /// - "alphabet"
    ///
    /// Defaults to `.default` if an unsupported type is provided.
    public func blockKeyboardType(_ type: String) -> some View {
        #if os(iOS)
            var keyboardType: UIKeyboardType = .default

            switch type.lowercased() {
            case "asciicapable":
                keyboardType = .asciiCapable
            case "numbersandpunctuation":
                keyboardType = .numbersAndPunctuation
            case "url":
                keyboardType = .URL
            case "numberpad":
                keyboardType = .numberPad
            case "phonepad":
                keyboardType = .phonePad
            case "namephonepad":
                keyboardType = .namePhonePad
            case "emailaddress":
                keyboardType = .emailAddress
            case "decimalpad":
                keyboardType = .decimalPad
            case "twitter":
                keyboardType = .twitter
            case "websearch":
                keyboardType = .webSearch
            case "asciicapablenumberpad":
                keyboardType = .asciiCapableNumberPad
            case "alphabet":
                keyboardType = .alphabet
            default:
                keyboardType = .default
            }

            return self.keyboardType(keyboardType)
        #else
            return self
        #endif
    }
}

extension View {
    /// Configures autocapitalization behavior for text input fields within the view's environment.
    /// - Parameter type: A string representing the autocapitalization type (e.g., "allcharacters", "sentences", "words").
    /// - Returns: A view with the specified autocapitalization type applied.
    ///
    /// Supported autocapitalization types:
    /// - "allcharacters"
    /// - "sentences"
    /// - "words"
    ///
    /// Defaults to `.none` if an unsupported type is provided.
    public func blockAutocapitalization(_ type: String) -> some View {
        #if os(iOS)
            var autocapitalization: UITextAutocapitalizationType = .none

            switch type.lowercased() {
            case "allcharacters":
                autocapitalization = .allCharacters
            case "sentences":
                autocapitalization = .sentences
            case "words":
                autocapitalization = .words
            default:
                autocapitalization = .none
            }

            return self.autocapitalization(autocapitalization)
        #else
            return self
        #endif
    }
}

extension View {
    /// Configures the visibility of scroll indicators within the view's environment.
    /// - Parameter type: A string representing the scroll indicator visibility (e.g., "automatic", "hidden", "never", "visible").
    /// - Returns: A view with the specified scroll indicator visibility applied.
    ///
    /// Supported visibility options:
    /// - "automatic"
    /// - "hidden"
    /// - "never"
    /// - "visible"
    ///
    /// Defaults to `.visible` if an unsupported type is provided. This feature is available on iOS 16.0 and later.
    public func blockScrollIndicators(_ type: String) -> some View {
        if #available(iOS 16.0, *) {
            var scrollIndicatorVisibility: ScrollIndicatorVisibility = .automatic
            switch type.lowercased() {
            case "automatic":
                scrollIndicatorVisibility = .automatic
            case "hidden":
                scrollIndicatorVisibility = .hidden
            case "never":
                scrollIndicatorVisibility = .never
            case "visible":
                scrollIndicatorVisibility = .visible
            default:
                scrollIndicatorVisibility = .visible
            }
            return self.scrollIndicators(scrollIndicatorVisibility)
        } else {
            return self
        }
    }
}

extension String {
    func parseBlockList() -> [Any]? {
        return NativeJsonPath().query(jsonString: self, query: "$") as? [Any]
    }
}

extension View {
    public func blockOnTapGesture(enable : Bool = true ,_ action: @escaping () -> Void) -> some View {
        if enable {
            self.onTapGesture {
                action()
            }
        }
        return self
    }
}
