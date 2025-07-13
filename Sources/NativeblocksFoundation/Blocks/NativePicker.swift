import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Picker",
    keyType: "nativeblocks/picker",
    description: "A customizable picker component for selecting a single item from a list.",
    version: 1,
    versionName: "1.0.0"
)
struct NativePicker<Content: View>: View {

    var blockProps: BlockProps? = nil

    @NativeBlockData(
        description: "The number of items to display in the dropdown. Each item will be generated using the 'Item Content' slot.",
        defaultValue: "0"
    )
    var length: Int = 0

    @NativeBlockData(
        description:
            "The index of the currently selected item in the list. This value is used to preselect an item and is updated on selection.",
        defaultValue: "0"
    )
    var selectedIndex: Int = 0

    @NativeBlockSlot(
        description: "Defines how each item in the dropdown should be rendered. The closure receives the item's index as input."
    )
    var itemContent: (BlockIndex) -> Content

    @NativeBlockSlot(
        description:
            "An optional label view that appears as the title of the dropdown. If not provided, the dropdown will have no visible label."
    )
    var label: (() -> Content)? = nil

    @NativeBlockEvent(
        description: "Triggered when the user selects a new item. Also updates the 'selectedIndex' binding automatically.",
        dataBinding: ["selectedIndex"]
    )
    var onSelect: (Int) -> Void

    @NativeBlockProp(
        description: "Specifies the width of the dropdown. Use 'auto' to size automatically or 'fill' to expand to available space.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "Auto - based on content"),
            NativeBlockValuePickerOption("fill", "Fill - stretch to container"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    @NativeBlockProp(
        description: "Specifies the height of the dropdown. Use 'auto' to size based on content or 'fill' to stretch to fit the container.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "Auto - based on content"),
            NativeBlockValuePickerOption("fill", "Fill - stretch to container"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"

    @NativeBlockProp(
        description:
            "A layout weight used inside a horizontal or vertical stack. Values greater than 0 will cause the picker to expand and share space.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0.0"
    )
    var weight: CGFloat = 0.0

    @NativeBlockProp(
        description: "Controls the visual style of the picker",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "Automatic"),
            NativeBlockValuePickerOption("menu", "Menu"),
            NativeBlockValuePickerOption("wheel", "Wheel"),
            NativeBlockValuePickerOption("inline", "Inline"),
            NativeBlockValuePickerOption("palette", "Palette"),
            NativeBlockValuePickerOption("segmented", "Segmented"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Style"),
        defaultValue: "menu"
    )
    var pickerStyle: String = "menu"

    @State private var selectedIndexInternal: Int = 0

    private var index: Binding<Int> {
        Binding<Int>(
            get: { selectedIndexInternal },
            set: { newValue in
                selectedIndexInternal = newValue
                onSelect(newValue)
            }
        )
    }

    var body: some View {
        Picker(selection: index) {
            ForEach(0..<length, id: \.self) { index in
                itemContent(index)
            }
        } label: {
            label?()
        }
        .blockWidthAndHeightModifier(width, height)
        .weighted(weight, proxy: blockProps?.hierarchy?.last?.scope)
        .applyPickerStyle(pickerStyle)
        .onAppear {
            selectedIndexInternal = selectedIndex
        }
    }
}

struct NativePicker_Previews: PreviewProvider {

    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativePickerPreviewContainer()
            .padding()
            .previewLayout(.sizeThatFits)
    }

    struct NativePickerPreviewContainer: View {

        @State private var selectedIndex: Int = 0

        var body: some View {
            VStack(spacing: 16) {
                NativePicker(
                    length: 3,
                    selectedIndex: selectedIndex,
                    itemContent: { index in
                        getItem(index)

                    },
                    label: {
                        getItem(-1, defaultValue: "Picker auto")
                    },
                    onSelect: { index in
                        selectedIndex = index
                        print("Selected item at index: \(index)")
                    },
                    pickerStyle: "auto"
                )

                NativePicker(
                    length: 3,
                    selectedIndex: selectedIndex,
                    itemContent: { index in
                        getItem(index)

                    },
                    label: {
                        getItem(-1, defaultValue: "Picker menu")
                    },
                    onSelect: { index in
                        selectedIndex = index
                        print("Selected item at index: \(index)")
                    },
                    pickerStyle: "menu"
                )

                NativePicker(
                    length: 3,
                    selectedIndex: selectedIndex,
                    itemContent: { index in
                        getItem(index)

                    },
                    label: {
                        getItem(-1, defaultValue: "Picker wheel")
                    },
                    onSelect: { index in
                        selectedIndex = index
                        print("Selected item at index: \(index)")
                    },
                    pickerStyle: "wheel"
                )

                NativePicker(
                    length: 3,
                    selectedIndex: selectedIndex,
                    itemContent: { index in
                        getItem(index)

                    },
                    label: {
                        getItem(-1, defaultValue: "Picker inline")
                    },
                    onSelect: { index in
                        selectedIndex = index
                        print("Selected item at index: \(index)")
                    },
                    pickerStyle: "inline"
                )

                NativePicker(
                    length: 3,
                    selectedIndex: selectedIndex,
                    itemContent: { index in
                        getItem(index)

                    },
                    label: {
                        getItem(-1, defaultValue: "Picker palette")
                    },
                    onSelect: { index in
                        selectedIndex = index
                        print("Selected item at index: \(index)")
                    },
                    pickerStyle: "palette"
                )

                NativePicker(
                    length: 3,
                    selectedIndex: selectedIndex,
                    itemContent: { index in
                        getItem(index)

                    },
                    label: {
                        getItem(-1, defaultValue: "Picker segmented")
                    },
                    onSelect: { index in
                        selectedIndex = index
                        print("Selected item at index: \(index)")
                    },
                    pickerStyle: "segmented"
                )

                getItem(selectedIndex)
            }
        }

        func getItem(_ index: Int, defaultValue: String? = nil) -> some View {
            switch index {
            case 0:
                return Text("🍎 Apple")
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(8)
            case 1:
                return Text("🍌 Banana")
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(8)
            case 2:
                return Text("🍇 Grape")
                    .padding()
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(8)
            default:
                return Text(defaultValue ?? "Unknown")
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(8)
            }
        }
    }
}
