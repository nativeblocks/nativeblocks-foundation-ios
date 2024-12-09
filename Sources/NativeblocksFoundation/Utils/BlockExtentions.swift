import Foundation
import SwiftUI

/// Maps a horizontal alignment string to the corresponding `HorizontalAlignment`.
/// - Parameter alignment: The alignment string (e.g., "leading", "trailing", "center").
/// - Returns: The mapped `HorizontalAlignment` value.
func mapBlockAlignmentHorizontal(_ alignment: String) -> HorizontalAlignment {
    switch alignment.lowercased() {
    case "leading": return .leading
    case "trailing": return .trailing
    case "listrowseparatorleading":
        if #available(iOS 16.0, *) {
            return .listRowSeparatorLeading
        } else {
            return .leading
        }
    case "listrowseparatortrailing":
        if #available(iOS 16.0, *) {
            return .listRowSeparatorTrailing
        } else {
            return .leading
        }
    case "center": return .center
    default: return .leading
    }
}

/// Maps a scrollable axis string to the corresponding `Axis.Set`.
/// - Parameter scroll: The scroll string (e.g., "horizontal", "vertical", "both").
/// - Returns: The mapped `Axis.Set` value.
func mapBlockScrollable(_ scroll: String) -> Axis.Set {
    switch scroll.lowercased() {
    case "horizontal": return .horizontal
    case "vertical": return .vertical
    case "both": return [.vertical, .horizontal]
    default: return [.vertical, .horizontal]
    }
}

/// Maps a vertical alignment string to the corresponding `VerticalAlignment`.
/// - Parameter alignment: The alignment string (e.g., "top", "bottom", "center").
/// - Returns: The mapped `VerticalAlignment` value.
func mapBlockVerticalAlignment(_ alignment: String) -> VerticalAlignment {
    switch alignment.lowercased() {
    case "top": return .top
    case "bottom": return .bottom
    case "center": return .center
    case "firsttextbaseline": return .firstTextBaseline
    case "lasttextbaseline": return .lastTextBaseline
    default: return .top
    }
}

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

    /// Aligns the text of a view based on the provided alignment string.
    /// - Parameter alignment: The alignment string (e.g., "leading", "center", "trailing").
    /// - Returns: A view with the specified text alignment.
    public func blockMultilineTextAlignment(_ alignment: String) -> some View {
        var textAlignment = TextAlignment.leading
        switch alignment.lowercased() {
        case "leading":
            textAlignment = .leading
        case "center":
            textAlignment = .center
        case "trailing":
            textAlignment = .trailing
        default:
            textAlignment = .leading
        }
        return self.multilineTextAlignment(textAlignment)
    }

    /// Applies a font style to the view.
    /// - Parameters:
    ///   - family: The font family (e.g., "system", "custom font name").
    ///   - size: The font size.
    ///   - weight: The font weight string (e.g., "regular", "bold").
    ///   - design: The font design string (e.g., "default", "serif").
    /// - Returns: A view with the specified font style.
    public func blockFont(family: String, size: CGFloat, weight: String, design: String) -> some View {
        var font: Font? = nil
        let fontWeight = self.mapFontWeight(weight)
        let fontDesign = self.mapFontDesign(design)
        switch family.lowercased() {
        case "system":
            font = .system(size: size, weight: fontWeight, design: fontDesign)
        default:
            font = .custom(family, size: size)
        }
        return self.font(font)
    }

    private func mapFontWeight(_ fontWeight: String) -> Font.Weight {
        switch fontWeight.lowercased() {
        case "ultralight": return .ultraLight
        case "thin": return .thin
        case "light": return .light
        case "regular": return .regular
        case "medium": return .medium
        case "semibold": return .semibold
        case "bold": return .bold
        case "heavy": return .heavy
        case "black": return .black
        default: return .regular
        }
    }

    private func mapFontDesign(_ fontWeight: String) -> Font.Design {
        switch fontWeight.lowercased() {
        case "default": return .default
        case "monospaced": return .monospaced
        case "rounded": return .rounded
        case "serif": return .serif
        default: return .default
        }
    }

    /// Sets the layout direction of the view's environment based on the specified direction.
    /// - Parameter direction: The layout direction as a string ("RTL" for right-to-left, otherwise defaults to left-to-right).
    /// - Returns: A view with the updated layout direction applied in its environment.
    ///
    /// This method updates the environment's layout direction, which is useful for supporting languages
    /// or regions that require right-to-left (RTL) layouts, such as Arabic or Hebrew.
    public func blockDirection(_ direction: String) -> some View {
        let blockDirection: LayoutDirection =
            if direction == "RTL" {
                LayoutDirection.rightToLeft
            } else {
                LayoutDirection.leftToRight
            }

        return self.environment(\.layoutDirection, blockDirection)
    }
}

/// Initializes a color from a hexadecimal string.
/// - Parameter blockHex: The hexadecimal color string (e.g., "#RRGGBB" or "#AARRGGBB").
extension Color {
    public init?(blockHex: String) {
        var hexSanitized = blockHex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            a = CGFloat((rgb & 0xFF00_0000) >> 24) / 255.0
            r = CGFloat((rgb & 0x00FF_0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x0000_FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000_00FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
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
