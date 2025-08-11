import Nativeblocks
import SwiftUI

public class NativeblocksFoundationTypeProvider {
    public static func provideTypes(name: String = "default") {
        NativeblocksManager.getInstance(name: name).provideTypeConverter(Color.self, converter: ColorNativeType())
        NativeblocksManager.getInstance(name: name).provideTypeConverter(Font.Design.self, converter: FontDesignNativeType())
        NativeblocksManager.getInstance(name: name).provideTypeConverter(Font.Weight.self, converter: FontWeightNativeType())
        NativeblocksManager.getInstance(name: name).provideTypeConverter(
            HorizontalAlignment.self, converter: HorizontalAlignmentNativeType())
        NativeblocksManager.getInstance(name: name).provideTypeConverter(LayoutDirection.self, converter: LayoutDirectionNativeType())
        NativeblocksManager.getInstance(name: name).provideTypeConverter(Axis.Set.self, converter: ScrollableNativeType())
        NativeblocksManager.getInstance(name: name).provideTypeConverter(TextAlignment.self, converter: TextAlignmentNativeType())
        NativeblocksManager.getInstance(name: name).provideTypeConverter(VerticalAlignment.self, converter: VerticalAlignmentNativeType())
    }
}
