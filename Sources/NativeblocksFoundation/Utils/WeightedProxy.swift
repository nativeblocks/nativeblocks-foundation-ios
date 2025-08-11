import SwiftUI

public class WeightedProxy {
    let kind: Kind
    let totalWeight: CGFloat = 1.0
    var geo: GeometryProxy? = nil

    init(kind: Kind) {
        self.kind = kind
    }

    internal func dimensionForRelative(weight: CGFloat) -> CGFloat {
        guard let geo = geo,
            totalWeight > 0
        else {
            return 0
        }
        let dimension = (kind == .vertical) ? geo.size.height : geo.size.width
        return dimension * weight / totalWeight
    }

    public enum Kind {
        case vertical, horizontal
    }
}

public struct Weighted: ViewModifier {
    private let weight: CGFloat
    private let proxy: WeightedProxy?
    init(_ weight: CGFloat, proxyObject: Any?) {
        self.weight = weight
        if let proxy = proxyObject as? WeightedProxy, weight != 0 {
            self.proxy = proxy
        } else {
            proxy = nil
        }
    }

    @ViewBuilder public func body(content: Content) -> some View {
        if proxy == nil || proxy?.totalWeight == 0 {
            content
        } else if proxy?.kind == .vertical {
            content.frame(height: proxy!.dimensionForRelative(weight: weight))
        } else {
            content.frame(width: proxy!.dimensionForRelative(weight: weight))
        }
    }
    private final class ViewTag {}
}

extension View {
    public func weighted(_ weight: CGFloat, proxy: Any?) -> some View {
        return self.modifier(Weighted(weight, proxyObject: proxy))
    }
}
