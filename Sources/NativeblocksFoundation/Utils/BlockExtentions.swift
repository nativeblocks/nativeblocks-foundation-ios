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

extension String {
    func parseBlockList() -> [Any]? {
        return NativeJsonPath().query(jsonString: self, query: "$") as? [Any]
    }
}
