import Nativeblocks
import SwiftUI

#if os(iOS)
    import UIKit
#endif

public class NativeblocksFoundationTypeProvider {
    public static func provideTypes() {
        NativeblocksManager.getInstance().provideTypeSerializer(Color.self, serializer: ColorNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(Font.Design.self, serializer: FontDesignNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(Font.Weight.self, serializer: FontWeightNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(HorizontalAlignment.self, serializer: HorizontalAlignmentNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(LayoutDirection.self, serializer: LayoutDirectionNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(Axis.Set.self, serializer: ScrollableNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(
            ScrollIndicatorVisibility.self, serializer: ScrollIndicatorVisibilityNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(TextAlignment.self, serializer: TextAlignmentNativeType())
        NativeblocksManager.getInstance().provideTypeSerializer(VerticalAlignment.self, serializer: VerticalAlignmentNativeType())

        #if os(iOS)
            NativeblocksManager.getInstance().provideTypeSerializer(
                UITextAutocapitalizationType.self, serializer: UITextAutocapitalizationTypeNativeType())
            NativeblocksManager.getInstance().provideTypeSerializer(UIKeyboardType.self, serializer: UIKeyboardTypeNativeType())
        #endif
    }
}
