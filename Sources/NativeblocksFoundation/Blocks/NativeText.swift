import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Text",
    keyType: "NATIVE_TEXT",
    description: "Nativeblocks text block",
    version: 1
)
struct NativeText: View {
    @NativeBlockData
    var text: String
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var fontFamily: String = "system"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("regular", "regular"),
            NativeBlockValuePickerOption("thin", "thin"),
            NativeBlockValuePickerOption("medium", "medium"),
            NativeBlockValuePickerOption("semibold", "semibold"),
            NativeBlockValuePickerOption("bold", "bold"),
            NativeBlockValuePickerOption("heavy", "heavy"),
            NativeBlockValuePickerOption("black", "black"),
            NativeBlockValuePickerOption("light", "light"),
            NativeBlockValuePickerOption("ultralight", "ultralight"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var fontWeight: String = "regular"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("default", "default"),
            NativeBlockValuePickerOption("monospaced", "monospaced"),
            NativeBlockValuePickerOption("rounded", "rounded"),
            NativeBlockValuePickerOption("serif", "serif"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var fontDesign: String = "default"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var fontSize: CGFloat = 16
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var foregroundColor: String = "#ff000000"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var multilineTextAlignment: String = "leading"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var lineLimit: Int = 9999
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var lineSpacing: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "LTR"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction")
    )
    var direction: String = "LTR"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingTop: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingLeading: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingBottom: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingTrailing: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameWidth: String = "notSet"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameHeight: String = "notSet"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "leading"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentVertical: String = "top"

    var body: some View {
        Text(text)
            .blockFont(
                family: fontFamily,
                size: fontSize,
                weight: fontWeight,
                design: fontDesign
            )
            .foregroundColor(Color(blockHex: foregroundColor) ?? Color.black.opacity(0))
            .blockMultilineTextAlignment(multilineTextAlignment)
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
            .blockWidthAndHeightModifier(
                frameWidth,
                frameHeight,
                alignment: Alignment(
                    horizontal: mapBlockAlignmentHorizontal(alignmentHorizontal),
                    vertical: mapBlockVerticalAlignment(alignmentVertical)
                )
            )
            .padding(.top, paddingTop)
            .padding(.leading, paddingLeading)
            .padding(.bottom, paddingBottom)
            .padding(.trailing, paddingTrailing)
            .blockDirection(direction)
    }
}

#Preview("NativeText") {
    NativeText(
        text: "Sample Sample Sample Sample\nSample\nSample\nSample Sample Sample Sample Sample\nSample\n",
        fontFamily: "system",
        fontWeight: "bold",
        fontDesign: "monospaced",
        fontSize: 20,
        foregroundColor: "#ff0000ff",
        multilineTextAlignment: "leading",
        lineLimit: 3,
        lineSpacing: 9,
        direction: "LTR",
        paddingTop: 8,
        paddingLeading: 8,
        paddingBottom: 8,
        paddingTrailing: 8,
        frameWidth: "infinity",
        frameHeight: "infinity"
    )
}
