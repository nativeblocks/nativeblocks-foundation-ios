import Foundation
import SwiftUI

func mapBlockAlignmentHorizontal(_ alignment: String) -> HorizontalAlignment {
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

func mapBlockVerticalAlignment(_ alignment: String) -> VerticalAlignment {
    switch alignment.lowercased() {
    case "top": return .top
    case "bottom": return .bottom
    case "center": return .center
    case "firstTextBaseline": return .firstTextBaseline
    case "lastTextBaseline": return .lastTextBaseline
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

public extension String {
    func isValidImageUrl() -> Bool {
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
    func blockWidthAndHeightModifier(_ width: String?, _ height: String?) -> some View {
        self.modifier(WidthAndHeightModifier(width: width, height: height))
    }
}

public extension View {
    func blockMultilineTextAlignment(_ alignment: String) -> some View {
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
    func blockFont(family: String, size: CGFloat, weight: String, design: String) -> some View {
        var font: Font? = nil
        var fontWeight = self.mapFontWeight(weight)
        var fontDesign = self.mapFontDesign(design)
        switch family.lowercased() {
        case "system":
            font = .system(size: size, weight: fontWeight, design: fontDesign)
        case "center":
            font = .custom(family, size: size)
        default:
            font = nil
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

public extension View {
    func blockDirection(_ direction: String) -> some View {
        let blockDirection: LayoutDirection =
            if direction == "RTL" {
                LayoutDirection.rightToLeft
            } else {
                LayoutDirection.leftToRight
            }

        return self.environment(\.layoutDirection, blockDirection)
    }
}

public extension View {
    func blockAspectRatio( ratio: CGFloat,mode:String) -> some View {
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
        
        if(ratio > 0){
            aspectRatio = ratio
        }
        
        return self.aspectRatio(aspectRatio, contentMode: contentMode)
        
    }
}

public extension Image {
    func blockResizable(_ mode:String) -> Image {
        var  resizingMode: Image.ResizingMode? = nil
        switch mode.lowercased() {
        case "stretch":
            resizingMode = .stretch
        case "tile":
            resizingMode = .tile
        default:
            resizingMode = nil
        }
        
        if resizingMode != nil{
            return self.resizable(resizingMode: resizingMode!)
        }else{
            return self
        }
    }
}

public extension Image {
    func blockInterpolation(_ value: String) -> Image{
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

public extension Color {
    init?(blockHex: String) {
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
