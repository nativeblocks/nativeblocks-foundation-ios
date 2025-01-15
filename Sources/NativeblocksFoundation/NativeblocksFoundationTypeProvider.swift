import Nativeblocks
import SwiftUI

public class NativeblocksFoundationTypeProvider {
    public static func provideTypes() {
        NativeblocksManager.getInstance().provideTypeConverter(Color.self, converter: ColorNativeType())
        NativeblocksManager.getInstance().provideTypeConverter(Font.Design.self, converter: FontDesignNativeType())
        NativeblocksManager.getInstance().provideTypeConverter(Font.Weight.self, converter: FontWeightNativeType())
        NativeblocksManager.getInstance().provideTypeConverter(HorizontalAlignment.self, converter: HorizontalAlignmentNativeType())
        NativeblocksManager.getInstance().provideTypeConverter(LayoutDirection.self, converter: LayoutDirectionNativeType())
        NativeblocksManager.getInstance().provideTypeConverter(Axis.Set.self, converter: ScrollableNativeType())
        NativeblocksManager.getInstance().provideTypeConverter(TextAlignment.self, converter: TextAlignmentNativeType())
        NativeblocksManager.getInstance().provideTypeConverter(VerticalAlignment.self, converter: VerticalAlignmentNativeType())
    }
}
