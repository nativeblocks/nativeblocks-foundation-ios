import Kingfisher
import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Image",
    keyType: "NATIVE_IMAGE",
    description: "Nativeblocks image block",
    version: 1
)
struct NativeImage<Content: View>: View {
    @NativeBlockData
    var imageUrl: String
    @NativeBlockSlot
    var placeHolder: (BlockIndex) -> Content
    @NativeBlockSlot
    var errorView: (BlockIndex) -> Content
    @NativeBlockData
    var contentDescription: String = ""
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("fill", "fill"),
            NativeBlockValuePickerOption("fit", "fit"),
        ]
    )
    var contentMode: String = "fit"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("stretch", "stretch"),
            NativeBlockValuePickerOption("tile", "tile"),
        ]
    )
    var resizable: String = "stretch"
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
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var cornerRadius: CGFloat = 0

    var body: some View {
        let shape = roundedRectangleShape(cornerRadius)
        let background = Color(blockHex: backgroundColor) ?? Color.black.opacity(0)

        if imageUrl.isValidImageUrl() {
            KFImage(URL(string: imageUrl))
                .placeholder {
                    placeHolder(-1)
                }
                .resizable()
                .blockResizable(resizable)
                .blockScaled(contentMode)
                .blockWidthAndHeightModifier(frameWidth, frameHeight)
                .contentShape(.rect)
                .background(background)
                .clipShape(shape)
                .accessibility(label: Text(contentDescription))
        } else {
            errorView(-1)
        }
    }
}
