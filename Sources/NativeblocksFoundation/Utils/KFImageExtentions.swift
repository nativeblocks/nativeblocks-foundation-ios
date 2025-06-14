import Foundation
import Kingfisher
import SwiftUI

extension View {
    /// Scales the view based on the specified scaling mode.
    /// - Parameter scale: The scaling mode as a string (e.g., "fill", "fit").
    /// - Returns: A view scaled according to the specified mode.
    public func blockScaled(_ scale: String) -> some View {
        switch scale {
        case "fill":
            return AnyView(self.scaledToFill())
        case "fit":
            return AnyView(self.scaledToFit())
        default:
            return AnyView(self.scaledToFit())
        }
    }
}

extension KFImage {
    /// Makes the image resizable based on the specified resizing mode.
    /// - Parameter mode: The resizing mode as a string (e.g., "stretch", "tile").
    /// - Returns: A `KFImage` object configured with the specified resizing mode.
    public func blockResizable(_ mode: String) -> KFImage {
        var resizingMode: Image.ResizingMode? = nil
        switch mode {
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

extension KFImage {
    /// Configures the image interpolation quality.
    /// - Parameter value: The interpolation quality as a string (e.g., "high", "medium", "low").
    /// - Returns: A `KFImage` object with the specified interpolation setting.
    public func blockInterpolation(_ value: String) -> KFImage {
        var interpolation: Image.Interpolation = .none

        switch value {
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

extension View {
    /// Sets the aspect ratio of the view based on a given ratio and mode.
    /// - Parameters:
    ///   - ratio: The aspect ratio as a `CGFloat`.
    ///   - mode: The content mode as a string (e.g., "fill").
    /// - Returns: A view with the specified aspect ratio and mode applied.
    public func blockAspectRatio(ratio: CGFloat, mode: String) -> some View {
        switch mode {
        case "fill":
            return AnyView(self)
        default:
            if ratio > 0 {
                return AnyView(
                    self
                        .aspectRatio(ratio, contentMode: .fit))
            } else {
                return AnyView(
                    self
                        .aspectRatio(contentMode: .fit))
            }
        }
    }
}
