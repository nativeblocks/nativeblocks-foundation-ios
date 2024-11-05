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
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
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
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var fontWeight: String = "regular"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var foregroundColor: String = "#ff000000"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#00000000"
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
    var lineLimit: String = ""
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var lineSpacing: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Shadow"))
    var shadowRadius: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Shadow")
    )
    var shadowColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var padding: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
            NativeBlockValuePickerOption("nan", "nan"),
            NativeBlockValuePickerOption("zero", "zero"),
            NativeBlockValuePickerOption("greatestFiniteMagnitude", "greatestFiniteMagnitude"),
            NativeBlockValuePickerOption("leastNormalMagnitude", "leastNormalMagnitude"),
            NativeBlockValuePickerOption("leastNonzeroMagnitude", "leastNonzeroMagnitude"),
            NativeBlockValuePickerOption("pi", "pi"),
            NativeBlockValuePickerOption("ulpOfOne", "ulpOfOne"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameMinWidth: String = "notSet"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
            NativeBlockValuePickerOption("nan", "nan"),
            NativeBlockValuePickerOption("zero", "zero"),
            NativeBlockValuePickerOption("greatestFiniteMagnitude", "greatestFiniteMagnitude"),
            NativeBlockValuePickerOption("leastNormalMagnitude", "leastNormalMagnitude"),
            NativeBlockValuePickerOption("leastNonzeroMagnitude", "leastNonzeroMagnitude"),
            NativeBlockValuePickerOption("pi", "pi"),
            NativeBlockValuePickerOption("ulpOfOne", "ulpOfOne"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameMinHeight: String = "notSet"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
            NativeBlockValuePickerOption("nan", "nan"),
            NativeBlockValuePickerOption("zero", "zero"),
            NativeBlockValuePickerOption("greatestFiniteMagnitude", "greatestFiniteMagnitude"),
            NativeBlockValuePickerOption("leastNormalMagnitude", "leastNormalMagnitude"),
            NativeBlockValuePickerOption("leastNonzeroMagnitude", "leastNonzeroMagnitude"),
            NativeBlockValuePickerOption("pi", "pi"),
            NativeBlockValuePickerOption("ulpOfOne", "ulpOfOne"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameMaxWidth: String = "notSet"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
            NativeBlockValuePickerOption("nan", "nan"),
            NativeBlockValuePickerOption("zero", "zero"),
            NativeBlockValuePickerOption("greatestFiniteMagnitude", "greatestFiniteMagnitude"),
            NativeBlockValuePickerOption("leastNormalMagnitude", "leastNormalMagnitude"),
            NativeBlockValuePickerOption("leastNonzeroMagnitude", "leastNonzeroMagnitude"),
            NativeBlockValuePickerOption("pi", "pi"),
            NativeBlockValuePickerOption("ulpOfOne", "ulpOfOne"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameMaxHeight: String = "notSet"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("leadingLastTextBaseline", "leadingLastTextBaseline"),
            NativeBlockValuePickerOption("leadingFirstTextBaseline", "leadingFirstTextBaseline"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("trailingLastTextBaseline", "trailingLastTextBaseline"),
            NativeBlockValuePickerOption("trailingFirstTextBaseline", "trailingFirstTextBaseline"),
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("topLeading", "topLeading"),
            NativeBlockValuePickerOption("topTrailing", "topTrailing"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("bottomLeading", "bottomLeading"),
            NativeBlockValuePickerOption("bottomTrailing", "bottomTrailing"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("centerFirstTextBaseline", "centerFirstTextBaseline"),
            NativeBlockValuePickerOption("centerLastTextBaseline", "centerLastTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var alignment: String = "center"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var cornerRadius: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var borderWidth: CGFloat = 0

    var body: some View {
        Text(text)
            .font(Helper.mapFont(font))
            .fontWeight(Helper.mapFontWeight(fontWeight))
            .foregroundColor(Helper.mapHexColor(foregroundColor))
            .multilineTextAlignment(Helper.mapTextAlignment(multilineTextAlignment))
            .lineLimit(Helper.mapStringToNullableInt(lineLimit))
            .lineSpacing(lineSpacing)
            .padding(padding)
            .frame(alignment: Helper.mapAlignment(alignment))
            .frame(maxWidth:  Helper.mapStringToSize(frameMaxWidth))
            .frame(maxHeight: Helper.mapStringToSize(frameMaxHeight))
            .frame(minWidth:  Helper.mapStringToSize(frameMinWidth))
            .frame(minHeight: Helper.mapStringToSize(frameMinHeight))
            .background(Helper.mapHexColor(backgroundColor))
            .cornerRadius(cornerRadius)
            .border(Helper.mapHexColor(borderColor), width: borderWidth)
            .shadow(color: Helper.mapHexColor(shadowColor), radius: shadowRadius)
    }
}
