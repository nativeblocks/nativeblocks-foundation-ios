import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Dropdown",
    keyType: "nativeblocks/dropdown",
    description: "A dropdown-style menu that displays a list of selectable items.",
    version: 1,
    versionName: "1.0.0"
)
struct NativeDropdown<Content: View>: View {

    var blockProps: BlockProps? = nil

    // MARK: - Data & Slots

    @NativeBlockData(
        description: "The total number of items to be displayed in the dropdown menu.",
        defaultValue: "0"
    )
    var length: Int = 0

    @NativeBlockData(
        description: "The index of the currently selected item. The default is 0.",
        defaultValue: "0"
    )
    var selectedIndex: Int = 0

    @NativeBlockData(
        description: "When true, the dropdown is disabled and does not respond to user interaction.",
        defaultValue: "false"
    )
    var isDisabled: Bool = false

    @NativeBlockSlot(
        description: "Renders each item based on its index. You can customize the visual appearance of every row in the dropdown."
    )
    var itemContent: (BlockIndex) -> Content

    @NativeBlockEvent(
        description: "Callback triggered when the user selects an item. Updates the `selectedIndex`.",
        dataBinding: ["selectedIndex"]
    )
    var onSelect: (Int) -> Void

    // MARK: - Size Properties

    @NativeBlockProp(
        description: "Picker icon color.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Icon"),
        defaultValue: "#CCCCCC"
    )
    var pickerIconColor: Color = Color.gray

    @NativeBlockProp(
        description: "Picker icon color.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Icon"),
        defaultValue: "#88CCCCCC"
    )
    var disablePickerIconColor: Color = Color.gray.opacity(0.3)

    @NativeBlockProp(
        description: "Defines the width of the dropdown container. Use 'auto' for intrinsic width or 'fill' to expand fully in its parent.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    @NativeBlockProp(
        description:
            "Defines the height of the dropdown container. Use 'auto' for intrinsic height or 'fill' to occupy all available vertical space.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"

    @NativeBlockProp(
        description: "Weight value for layout distribution in horizontal or vertical stacks. Use 0 for no weight.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0.0"
    )
    var weight: CGFloat = 0.0

    // MARK: - Style: Border and Background

    @NativeBlockProp(
        description: "Text color of the dropdown label and items.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#000000"
    )
    var textColor: Color = .black

    @NativeBlockProp(
        description: "Font size used for the dropdown items and label.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "16"
    )
    var fontSize: CGFloat = 16

    @NativeBlockProp(
        description: "Corner radius for rounding the edges of the menu container.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "8.0"
    )
    var cornerRadius: CGFloat = 8.0

    @NativeBlockProp(
        description: "Background color of the main dropdown button.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.clear

    @NativeBlockProp(
        description: "Stroke color for the dropdown’s border.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#CCCCCC"
    )
    var borderColor: Color = Color.gray

    @NativeBlockProp(
        description: "Thickness of the border around the dropdown.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "1.0"
    )
    var borderWidth: CGFloat = 1.0

    // MARK: - Style: Padding

    @NativeBlockProp(
        description: "Padding at the top edge of the dropdown container.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTop: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the leading edge of the dropdown container.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingLeading: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the bottom edge of the dropdown container.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingBottom: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the trailing edge of the dropdown container.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTrailing: CGFloat = 8

    @NativeBlockProp(
        description: "Background color when the dropdown is disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#F2F2F2"
    )
    var disabledBackgroundColor: Color = Color.gray.opacity(0.1)

    @NativeBlockProp(
        description: "Text color when the dropdown is disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#A0A0A0"
    )
    var disabledTextColor: Color = Color.gray
    // MARK: - View

    var body: some View {
        VStack {
            Menu {
                ForEach(0..<length, id: \.self) { index in
                    Button(action: {
                        onSelect(index)
                    }) {
                        HStack {
                            itemContent(index)
                                .id(selectedIndex)
                                .font(.system(size: fontSize))
                                .foregroundColor(isDisabled ? disabledTextColor : textColor)

                            if index == selectedIndex {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .disabled(isDisabled)
                }
            } label: {
                HStack {
                    itemContent(selectedIndex)
                        .font(.system(size: fontSize))
                        .foregroundColor(isDisabled ? disabledTextColor : textColor)
                        .id(selectedIndex)

                    Image(systemName: "chevron.down")
                        .foregroundColor(isDisabled ? disablePickerIconColor : pickerIconColor)
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
            .disabled(isDisabled)
        }
    }
}

struct NativePickerMenu_Previews: PreviewProvider {

    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeDropdownPreviewContainer()
            .padding()
            .previewLayout(.sizeThatFits)
    }

    struct NativeDropdownPreviewContainer: View {
        @State private var selectedIndex: Int = 0

        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                NativeDropdown(
                    length: 3,
                    selectedIndex: selectedIndex,
                    itemContent: { index in getItem(index) },
                    onSelect: { index in selectedIndex = index },
                    width: "fill",
                )

                NativeDropdown(
                    length: 3,
                    selectedIndex: selectedIndex,
                    isDisabled: true,
                    itemContent: { index in getItem(index) },
                    onSelect: { index in selectedIndex = index },
                )

                getItem(selectedIndex)
            }
        }

        func getItem(_ index: Int, defaultValue: String? = nil) -> some View {
            let text: String
            let color: Color

            switch index {
            case 0:
                text = "🍎 Apple"
                color = .red.opacity(0.2)
            case 1:
                text = "🍌 Banana"
                color = .yellow.opacity(0.2)
            case 2:
                text = "🍇 Grape"
                color = .purple.opacity(0.2)
            default:
                text = defaultValue ?? "Unknown"
                color = .gray.opacity(0.1)
            }

            return HStack {
                Text(text)
                    .padding(6)
                    .background(color)
                    .cornerRadius(6)
            }
        }
    }
}
