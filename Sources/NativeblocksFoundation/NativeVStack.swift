import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native VStack",
    keyType: "NATIVE_VSTACK",
    description: "Native VStack block"
)
struct NativeVStack<Content: View>: View {
    @NativeBlockSlot
    var content: (Int) -> Content
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ]
    )
    var alignment: String = "center"
    @NativeBlockProp
    var spacing: CGFloat? = 10
    @NativeBlockProp
    var paddingTop: CGFloat = 0
    @NativeBlockProp
    var paddingLeading: CGFloat = 0
    @NativeBlockProp
    var paddingBottom: CGFloat = 0
    @NativeBlockProp
    var paddingTrailing: CGFloat = 0
    @NativeBlockProp
    var frameWidth: CGFloat? = 100
    @NativeBlockProp
    var frameHeight: CGFloat? = 100
    @NativeBlockProp
    var backgroundColor: String = "#FFFFFF"
    @NativeBlockProp
    var cornerRadius: CGFloat = 0
    @NativeBlockProp
    var borderColor: String = "#000000"
    @NativeBlockProp
    var borderWidth: CGFloat = 1
    @NativeBlockProp
    var shadowColor: String = "#000000"
    @NativeBlockProp
    var shadowRadius: CGFloat = 1
    @NativeBlockProp
    var shadowX: CGFloat = 0
    @NativeBlockProp
    var shadowY: CGFloat = 0

    var body: some View {
        VStack(alignment: Helper.mapAlignment(alignment), spacing: spacing) {
            content(-1)
        }
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .frame(width: frameWidth, height: frameHeight)
        .background(Helper.mapHexColor(backgroundColor))
        .cornerRadius(cornerRadius)
        .border(Helper.mapHexColor(borderColor), width: borderWidth)
        .shadow(color: Helper.mapHexColor(shadowColor), radius: shadowRadius, x: shadowX, y: shadowY)
    }
}
