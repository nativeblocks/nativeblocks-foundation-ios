import Foundation
import Nativeblocks
import SwiftUI

enum BlockHelper {
    static func mapAlignmentHorizontal(_ alignment: String) -> HorizontalAlignment {
        switch alignment.lowercased() {
        case "leading": return .leading
        case "trailing": return .trailing
        case "center": if #available(iOS 16.0, *) {
            return .listRowSeparatorLeading
        } else {
            return .leading
        }
        case "center": if #available(iOS 16.0, *) {
            return .listRowSeparatorTrailing
        } else {
            return .leading
        }
        case "center": return .center
        default: return .leading
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
}

public struct WidthAndHeightModifier: ViewModifier {
    var width: String?
    var height: String?
    init(width: String? = nil, height: String? = nil) {
        self.width = width
        self.height = height
    }

    public func body(content: Content) -> some View {
        content
            .modifier(WidthModifier(width: self.width))
            .modifier(HeightModifier(height: self.height))
    }
}

public struct HeightModifier: ViewModifier {
    var height: String?

    public func body(content: Content) -> some View {
        if let height = height {
            switch height.lowercased() {
            case "infinity":
                return AnyView(content.frame(maxHeight: .infinity))
            default:
                if let heightValue = Double(height) {
                    return AnyView(content.frame(height: CGFloat(heightValue)))
                }
            }
        }
        return AnyView(content)
    }
}

public struct WidthModifier: ViewModifier {
    var width: String?

    public func body(content: Content) -> some View {
        if let width = width {
            switch width.lowercased() {
            case "infinity":
                return AnyView(content.frame(maxWidth: .infinity))
            default:
                if let widthValue = Double(width) {
                    return AnyView(content.frame(width: CGFloat(widthValue)))
                }
            }
        }
        return AnyView(content)
    }
}

public extension View {
    func widthAndHeightModifier(_ width: String?, _ height: String?) -> some View {
        self.modifier(WidthAndHeightModifier(width: width, height: height))
    }
}

public extension View {
    func multilineTextAlignment(_ alignment: String) -> some View {
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

public extension View {
    func font(family: String, size: CGFloat, weight : String,design:String) -> some View {
        var font: Font? = nil
        var fontWeight = mapFontWeight(weight)
        var fontDesign = mapFontDesign(design)
        switch family.lowercased() {
        case "system":
            font = .system(size: size,weight: fontWeight, design: fontDesign)
        case "center":
            font = .custom(family, size: size)
        default:
            font = nil
        }
        return self.font(font)
    }
    
    private func mapFontWeight(_ fontWeight: String) -> Font.Weight{
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


public extension View {
    func direction(_ direction: String) -> some View{
        let blockDirection: LayoutDirection =
            if direction == "RTL" {
                LayoutDirection.rightToLeft
            } else {
                LayoutDirection.leftToRight
            }
        
       return self.environment(\.layoutDirection, blockDirection)
    }
}
