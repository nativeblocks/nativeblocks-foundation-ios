import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Radio Group",
    keyType: "nativeblocks/radiogroup",
    description: "Displays a list of radio options. Only one item can be selected at a time.",
    version: 1,
    versionName: "1.0.0"
)
struct NativeRadioGroup<Content: View>: View {
    var blockProps: BlockProps? = nil

    @NativeBlockData(
        description: "Specifies the number of items to display in the radio group.",
        defaultValue: "0"
    )
    var length: Int = 0

    @NativeBlockData(
        description: "The index of the currently selected item.",
        defaultValue: "0"
    )
    var selectedIndex: Int = 0

    @NativeBlockData(
        description: "When true, the layout is disabled and does not respond to user interaction.",
        defaultValue: "false"
    )
    var isDisabled: Bool = false

    @NativeBlockSlot(
        description: "Defines the visual appearance of each item. Can include text, icons, or custom views."
    )
    var itemContent: (BlockIndex) -> Content

    @NativeBlockEvent(
        description: "Triggered when the user selects a new option.",
        dataBinding: ["selectedIndex"]
    )
    var onSelect: (Int) -> Void

    @NativeBlockProp(
        description: "The space between the selection circle and the item content.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Spacing"),
        defaultValue: "8"
    )
    var horizontalSpacing: CGFloat = 8

    @NativeBlockProp(
        description: "The vertical space between items in the list.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Spacing"),
        defaultValue: "8"
    )
    var verticalSpacing: CGFloat = 8

    @NativeBlockProp(
        description:
            "Defines the width of the component. Use 'auto' to size based on content, or 'fill' to take all available horizontal space.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "Auto"),
            NativeBlockValuePickerOption("fill", "Fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    @NativeBlockProp(
        description:
            "Defines the height of the component. Use 'auto' to size based on content, or 'fill' to take all available vertical space.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "Auto"),
            NativeBlockValuePickerOption("fill", "Fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"

    @NativeBlockProp(
        description: "A layout weight that determines how much space this view should occupy relative to siblings inside a stack.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0.0"
    )
    var weight: CGFloat = 0.0

    @NativeBlockProp(
        description: "Sets the horizontal alignment of all items inside the group.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "Leading"),
            NativeBlockValuePickerOption("trailing", "Trailing"),
            NativeBlockValuePickerOption("center", "Center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "leading"
    )
    var horizontalAlignment: HorizontalAlignment = .leading

    @NativeBlockProp(
        description: "Sets the vertical alignment of content inside each row (e.g., text baseline, center).",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "Top"),
            NativeBlockValuePickerOption("bottom", "Bottom"),
            NativeBlockValuePickerOption("center", "Center"),
            NativeBlockValuePickerOption("firstTextBaseline", "First Text Baseline"),
            NativeBlockValuePickerOption("lastTextBaseline", "Last Text Baseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "center"
    )
    var verticalAlignment: VerticalAlignment = .center

    @NativeBlockProp(
        description: "Specifies the color of the disabled selected indicator (radio circle).",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Colors"),
        defaultValue: "#FF0000FF"
    )
    var foregroundColor: Color = Color.blue

    @NativeBlockProp(
        description: "Specifies the color of the selected indicator (radio circle).",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Colors"),
        defaultValue: "#880000FF"
    )
    var disabledForegroundColor: Color = Color.blue.opacity(0.3)

    @NativeBlockProp(
        description: "Padding at the top edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTop: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the leading edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingLeading: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the bottom edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingBottom: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the trailing edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTrailing: CGFloat = 8

    @NativeBlockProp(
        description: "Corner radius for rounding the edges of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "8.0"
    )
    var cornerRadius: CGFloat = 8.0

    @NativeBlockProp(
        description: "Background color of the main layout button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.clear

    @NativeBlockProp(
        description: "Background color when the layout is disabled.",
        valuePickerGroup: NativeBlockValuePickerPosition("State"),
        defaultValue: "#F2F2F2"
    )
    var disabledBackgroundColor: Color = Color.gray.opacity(0.1)

    @NativeBlockProp(
        description: "Stroke color for the layout border.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#CCCCCC"
    )
    var borderColor: Color = Color.gray

    @NativeBlockProp(
        description: "Thickness of the border around the layout.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "1.0"
    )
    var borderWidth: CGFloat = 1.0

    var body: some View {
        VStack(alignment: horizontalAlignment, spacing: verticalSpacing) {
            ForEach(0..<length, id: \.self) { index in
                HStack(alignment: verticalAlignment, spacing: horizontalSpacing) {
                    Image(systemName: selectedIndex == index ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(isDisabled ? disabledForegroundColor : foregroundColor)
                        .imageScale(.large)
                    itemContent(index)
                }
                .onTapGesture {
                    if !isDisabled {
                        onSelect(index)
                    }
                }
            }
        }
        .blockWidthAndHeightModifier(width, height)
        .weighted(weight, proxy: blockProps?.hierarchy?.last?.scope)
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .background(isDisabled ? disabledBackgroundColor : backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }
}

struct NativeRadioGroup_Previews: PreviewProvider {

    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        RadioGroupPreviewContainer()
            .padding()
            .previewLayout(.sizeThatFits)
    }

    struct RadioGroupPreviewContainer: View {
        @State private var selectedIndex: Int = 1

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                NativeRadioGroup(
                    length: 3,
                    selectedIndex: selectedIndex,
                    isDisabled: false,
                    itemContent: { index in
                        Text(itemTitle(for: index))
                            .padding(.vertical, 4)
                    },
                    onSelect: { index in
                        selectedIndex = index
                        print("Selected index: \(index)")
                    },
                    horizontalSpacing: 8,
                    verticalSpacing: 8,
                    horizontalAlignment: .leading,
                    verticalAlignment: .center
                )

                Text("Selected: \(itemTitle(for: selectedIndex))")
                    .font(.footnote)
                    .padding(.top)
            }
        }

        func itemTitle(for index: Int) -> String {
            switch index {
            case 0: return "🍎 Apple"
            case 1: return "🍌 Banana"
            case 2: return "🍇 Grape"
            default: return "Unknown"
            }
        }
    }
}
