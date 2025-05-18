import SwiftUI

class WeightedProxy {
    let kind: Kind
    var geo: GeometryProxy? = nil
    private(set) var totalWeight: CGFloat = 1

    init(kind: Kind) {
        self.kind = kind
    }

    func dimensionForRelative(weight: CGFloat) -> CGFloat {

        guard let geo = geo,
            totalWeight > 0
        else {
            return 0
        }
        let dimension = (kind == .vertical) ? geo.size.height : geo.size.width
        return dimension * weight / totalWeight
    }

    enum Kind {
        case vertical, horizontal
    }
}

struct Weighted: ViewModifier {
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

    @ViewBuilder func body(content: Content) -> some View {
        if proxy == nil {
            content
        } else if proxy?.kind == .vertical {
            content.frame(height: proxy!.dimensionForRelative(weight: weight))
        } else {
            content.frame(width: proxy!.dimensionForRelative(weight: weight))
        }
    }
}

extension View {
    func weighted(_ weight: CGFloat, proxy: Any?) -> some View {
        self.modifier(Weighted(weight, proxyObject: proxy))
    }
}
