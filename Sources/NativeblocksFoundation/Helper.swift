import Foundation
import SwiftUI
import Nativeblocks

struct Helper {
    static func mapFont(_ font: String) -> Font {
        switch font.lowercased() {
        case "largetitle": return .largeTitle
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
        return Color(hex: hex) ?? Color.black.opacity(0)
    }

    static func mapTextAlignment(_ alignment: String) -> TextAlignment {
        switch alignment.lowercased() {
        case "leading": return .leading
        case "center": return .center
        case "trailing": return .trailing
        default: return .leading
        }
    }

    static func mapAlignmentHorizontal(_ alignment: String) -> HorizontalAlignment {
        switch alignment.lowercased() {
        case "leading": return .leading
        case "trailing": return .trailing
        case "center": return .center
        default: return .center
        }
    }
    
    static func mapAlignment(_ alignment: String) -> Alignment {
        switch alignment.lowercased() {
        case "leading": return .leading
        case "leadingLasttextbaseline": return .leadingLastTextBaseline
        case "leadingfirsttextbaseline": return .leadingFirstTextBaseline
        case "trailing": return .trailing
        case "trailinglasttextbaseline": return .trailingLastTextBaseline
        case "trailingfirsttextbaseline": return .trailingFirstTextBaseline
        case "top": return .top
        case "topleading": return .topLeading
        case "toptrailing": return .topTrailing
        case "bottom": return .bottom
        case "bottomleading": return .bottomLeading
        case "bottomtrailing": return .bottomTrailing
        case "center": return .center
        case "centerfirsttextbaseline": return .centerFirstTextBaseline
        case "centerlasttextbaseline": return .centerLastTextBaseline
        default:
            return .center
        }
    }
    
    static func mapStringToNullableInt(_ value :String)->Int?{
        if value.isEmpty {
            return nil
        } else {
            return Int(value)
        }
    }
    
    static func mapStringToSize(_ value :String)->CGFloat?{
        if let number =  Double(value) {
            return CGFloat( number)
        }else {
            switch value.lowercased() {
            case "infinity": return .infinity
            case "greatestfinitemagnitude": return .greatestFiniteMagnitude
            case "leastnormalmagnitude": return .leastNormalMagnitude
            case "leastnonzeromagnitude": return .leastNonzeroMagnitude
            case "nan": return .nan
            case "pi": return .pi
            case "ulpofone": return .ulpOfOne
            case "zero": return .zero
            default:
                return nil
            }
        }
    }
}
