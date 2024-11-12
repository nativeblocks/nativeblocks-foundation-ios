import Foundation
import SwiftUI

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

func mapBlockScrollable(_ scroll: String) -> Axis.Set {
    switch scroll.lowercased() {
    case "horizontal": return .horizontal
    case "vertical": return .vertical
    case "both": return [.vertical, .horizontal]
    default: return [.vertical, .horizontal]
    }
}

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

func mapBlockImageContentMode(_ mode: String) -> ContentMode {
    switch mode.lowercased() {
    case "fill": return .fill
    case "fit": return .fit
    default: return .fill
    }
}

extension String {
    public func isValidImageUrl() -> Bool {
        guard let url = URL(string: self) else {
            return false
        }

        guard url.scheme == "http" || url.scheme == "https" else {
            return false
        }

        #if os(iOS)
            return UIApplication.shared.canOpenURL(url)
        #else
            return true
        #endif
    }
}

extension View {
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
            minWidth: (maxWidth != nil && !maxWidth!.isNaN && maxWidth != .infinity) ? maxWidth : nil,
            maxWidth: (maxWidth != nil && !maxWidth!.isNaN) ? maxWidth : nil,
            minHeight: (maxHeight != nil && !maxHeight!.isNaN && maxHeight != .infinity) ? maxHeight : nil,
            maxHeight: (maxHeight != nil && !maxHeight!.isNaN) ? maxHeight : nil,
            alignment: alignment
        )
    }
}

extension View {
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
}

extension View {
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
}

extension View {
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

extension View {
    public func blockAspectRatio(ratio: CGFloat, mode: String) -> some View {
        var aspectRatio: CGFloat? = nil
        var contentMode: ContentMode = .fill

        switch mode.lowercased() {
        case "fill":
            contentMode = .fill
        case "fit":
            contentMode = .fit
        default:
            contentMode = .fill
        }

        if ratio > 0 {
            aspectRatio = ratio
        }

        return self.aspectRatio(aspectRatio, contentMode: contentMode)
    }
}

extension Image {
    public func blockResizable(_ mode: String) -> Image {
        var resizingMode: Image.ResizingMode? = nil
        switch mode.lowercased() {
        case "stretch":
            resizingMode = .stretch
        case "tile":
            resizingMode = .tile
        default:
            resizingMode = nil
        }

        if resizingMode != nil {
            return self.resizable(resizingMode: resizingMode!)
        } else {
            return self
        }
    }
}

extension Image {
    public func blockInterpolation(_ value: String) -> Image {
        var interpolation: Image.Interpolation = .none

        switch value.lowercased() {
        case "high":
            interpolation = .high
        case "low":
            interpolation = .low
        case "medium":
            interpolation = .medium
        default:
            interpolation = .none
        }
        return self.interpolation(interpolation)
    }
}

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

public func roundedRectangleShape(
    _ radius: CGFloat
) -> RoundedRectangle {
    return RoundedRectangle(cornerRadius: radius)
}

extension View {
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
    public func blockScrollIndicators(_ type: String) -> some View {
        if #available(iOS 16.0, *) {
            var autocapitalization: ScrollIndicatorVisibility = .automatic
            switch type.lowercased() {
            case "automatic":
                autocapitalization = .automatic
            case "hidden":
                autocapitalization = .hidden
            case "never":
                autocapitalization = .never
            case "visible":
                autocapitalization = .visible
            default:
                autocapitalization = .visible
            }
            return self.scrollIndicators(autocapitalization)
        } else {
            return self
        }
    }
}
