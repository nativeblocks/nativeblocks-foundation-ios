import Foundation
import Kingfisher
import SwiftUI

extension View {
    public func blockScaled(_ scale: String) -> some View {
        switch scale.lowercased() {
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
    public func blockResizable(_ mode: String) -> KFImage {
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

extension KFImage {
    public func blockInterpolation(_ value: String) -> KFImage {
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

extension View {
    public func blockAspectRatio(ratio: CGFloat, mode: String) -> some View {
        switch mode.lowercased() {
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
