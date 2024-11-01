import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Text",
    keyType: "NATIVE_TEXT",
    description: "Native text block"
)
struct NativeText: View {
    @NativeBlockData
    var text: String
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("largeTitle", "largeTitle"),
            NativeBlockValuePickerOption("title", "title"),
            NativeBlockValuePickerOption("title2", "title2"),
            NativeBlockValuePickerOption("title3", "title3"),
            NativeBlockValuePickerOption("headline", "headline"),
            NativeBlockValuePickerOption("subheadline", "subheadline"),
            NativeBlockValuePickerOption("body", "body"),
            NativeBlockValuePickerOption("callout", "callout"),
            NativeBlockValuePickerOption("caption", "caption"),
            NativeBlockValuePickerOption("caption2", "caption2"),
            NativeBlockValuePickerOption("footnote", "footnote"),
        ]
    )
    var font: String = "body"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("ultralight", "ultralight"),
            NativeBlockValuePickerOption("thin", "thin"),
            NativeBlockValuePickerOption("light", "light"),
            NativeBlockValuePickerOption("regular", "regular"),
            NativeBlockValuePickerOption("medium", "medium"),
            NativeBlockValuePickerOption("semibold", "semibold"),
            NativeBlockValuePickerOption("bold", "bold"),
            NativeBlockValuePickerOption("heavy", "heavy"),
            NativeBlockValuePickerOption("black", "black"),
        ]
    )
    var fontWeight: String = "regular"
    @NativeBlockProp
    var foregroundColor: String = "#000000"
    @NativeBlockProp
    var backgroundColor: String = "#FFFFFF"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ]
    )
    var multilineTextAlignment: String = "leading"
    @NativeBlockProp
    var lineLimit: Int? = 1
    @NativeBlockProp
    var lineSpacing: CGFloat = 1
    @NativeBlockProp
    var shadowRadius: CGFloat = 0
    @NativeBlockProp
    var shadowColor: String = "#000000"
    @NativeBlockProp
    var padding: CGFloat = 8
    @NativeBlockProp
    var frameWidth: CGFloat? = 150
    @NativeBlockProp
    var frameHeight: CGFloat? = 50
    @NativeBlockProp
    var cornerRadius: CGFloat = 5
    @NativeBlockProp
    var borderColor: String = "#000000"
    @NativeBlockProp
    var borderWidth: CGFloat = 1

    var body: some View {
        Text(text)
            .font(Helper.mapFont(font))
            .fontWeight(Helper.mapFontWeight(fontWeight))
            .foregroundColor(Helper.mapHexColor(foregroundColor))
            .multilineTextAlignment(Helper.mapTextAlignment(multilineTextAlignment))
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
            .padding(padding)
            .frame(width: frameWidth, height: frameHeight)
            .background(Helper.mapHexColor(backgroundColor))
            .cornerRadius(cornerRadius)
            .border(Helper.mapHexColor(borderColor), width: borderWidth)
            .shadow(color: Helper.mapHexColor(shadowColor), radius: shadowRadius)
    }
}
