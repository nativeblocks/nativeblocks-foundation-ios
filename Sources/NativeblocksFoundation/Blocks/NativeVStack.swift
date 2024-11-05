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
    var content: (BlockIndex) -> Content
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ]
    )
    var alignmentHorizontal: String = "center"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("infinity", "infinity"),
            NativeBlockValuePickerOption("nan", "nan"),
            NativeBlockValuePickerOption("zero", "zero"),
            NativeBlockValuePickerOption("greatestFiniteMagnitude", "greatestFiniteMagnitude"),
            NativeBlockValuePickerOption("leastNormalMagnitude", "leastNormalMagnitude"),
            NativeBlockValuePickerOption("leastNonzeroMagnitude", "leastNonzeroMagnitude"),
            NativeBlockValuePickerOption("pi", "pi"),
            NativeBlockValuePickerOption("ulpOfOne", "ulpOfOne"),
        ]
    )
    var spacing: String = ""
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
    var frameWidth: String = ""
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
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
    var frameHeight: String = ""
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
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var cornerRadius: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var borderWidth: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Shadow")
    )
    var shadowColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Shadow"))
    var shadowRadius: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Shadow"))
    var shadowX: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Shadow"))
    var shadowY: CGFloat = 0
    var body: some View {
        VStack(alignment: Helper.mapAlignmentHorizontal(alignmentHorizontal), spacing: Helper.mapStringToSize(spacing)) {
            content(-1)
        }
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .frame(width: Helper.mapStringToSize(frameWidth), height: Helper.mapStringToSize(frameHeight), alignment: Helper.mapAlignment(alignment))
        .background(Helper.mapHexColor(backgroundColor))
        .cornerRadius(cornerRadius)
        .border(Helper.mapHexColor(borderColor), width: borderWidth)
        .shadow(color: Helper.mapHexColor(shadowColor), radius: shadowRadius, x: shadowX, y: shadowY)
    }
}
