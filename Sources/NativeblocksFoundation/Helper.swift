import Foundation
import SwiftUI

struct Helper {
    static func mapFont(_ font: String) -> Font {
        switch font.lowercased() {
        case "largeTitle": return .largeTitle
        case "title": return .title
        case "title2": return .title2
        case "title3": return .title3
        case "headline": return .headline
        case "subheadline": return .subheadline
        case "body": return .body
        case "callout": return .callout
        case "caption": return .caption
        case "caption2": return .caption2
        case "footnote": return .footnote
        default: return .body
        }
    }

    static func mapFontWeight(_ fontWeight: String) -> Font.Weight {
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

    static func mapHexColor(_ hex: String) -> Color {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        guard hexFormatted.count == 6 else {
            return Color.clear
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        return Color(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0
        )
    }

    static func mapTextAlignment(_ alignment: String) -> TextAlignment {
        switch alignment.lowercased() {
        case "leading": return .leading
        case "center": return .center
        case "trailing": return .trailing
        default: return .leading
        }
    }

    func mapAlignment(_ alignment: String) -> HorizontalAlignment {
        switch alignment.lowercased() {
        case "leading": return .leading
        case "trailing": return .trailing
        case "center": return .center
        default: return .center
        }
    }
}
