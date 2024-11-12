import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native ScrollView",
    keyType: "NATIVE_SCROLLVIEW",
    description: "Nativeblocks ScrollView block"
)
struct NativeScrollView<Content: View>: View {
    @NativeBlockSlot
    var content: (BlockIndex) -> Content
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("hidden", "hidden"),
            NativeBlockValuePickerOption("never", "never"),
            NativeBlockValuePickerOption("visible", "visible"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable")
    )
    var scrollIndicators: String = "visible"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("vertical", "vertical"),
            NativeBlockValuePickerOption("horizontal", "horizontal"),
            NativeBlockValuePickerOption("both", "horizontal"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable")
    )
    var scrollDirection: String = "vertical"
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
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Alignment"))
    var spacing: CGFloat = 0
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
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var shadowRadius: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var shadowX: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var shadowY: CGFloat = 0
    @NativeBlockEvent
    var onClick: () -> Void

    var body: some View {
        ScrollView(mapBlockScrollable(scrollDirection)) {
            content(-1)
        }
        .blockScrollIndicators(scrollIndicators)
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
        .background(Color(blockHex: backgroundColor) ?? Color.black.opacity(0))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(
                cornerRadius:
                    cornerRadius
            ).stroke(
                Color(blockHex: borderColor) ?? Color.black.opacity(0),
                lineWidth: borderWidth
            )
        )
        .shadow(
            color: Color(blockHex: shadowColor) ?? Color.black.opacity(0),
            radius: shadowRadius, x: shadowX, y: shadowY
        )
        .blockDirection(direction)
        .onTapGesture {
            onClick()
        }
    }
}

#Preview("NativeVStack") {
    ZStack {
        NativeScrollView(
            content: { _ in
                HStack {

                    Text("Top Left Aligned")
                        .frame(
                            minWidth: 100,
                            maxWidth: 100,
                            minHeight: 100,
                            maxHeight: 100,
                            alignment: Alignment.center
                        )
                        .background(Color.brown)

                    Text("Top Left Aligned")
                        .frame(
                            minWidth: 100,
                            maxWidth: 100,
                            minHeight: 100,
                            maxHeight: 100,
                            alignment: Alignment.center
                        )
                        .background(Color.red)
                }
            },
            scrollIndicators: "visible",
            scrollDirection: "both",
            alignmentHorizontal: "center",
            alignmentVertical: "center",
            spacing: 0,
            direction: "RTL",
            paddingTop: 0,
            paddingLeading: 0,
            paddingBottom: 0,
            paddingTrailing: 0,
            frameWidth: "300",
            frameHeight: "infinity",
            backgroundColor: "#ff0000ff",
            cornerRadius: 30,
            borderColor: "#ff000000",
            borderWidth: 5,
            shadowColor: "#ff000000",
            shadowRadius: 30,
            shadowX: 7,
            shadowY: 7,
            onClick: {}
        )
    }
    .padding(10)
    .background(Color.blue)
}
