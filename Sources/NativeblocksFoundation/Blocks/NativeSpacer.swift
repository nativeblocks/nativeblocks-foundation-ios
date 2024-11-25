import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Spacer",
    keyType: "NATIVE_SPACER",
    description: "Nativeblocks spacer block",
    version: 1
)
struct NativeSpacer: View {
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

    var body: some View {
        Spacer()
            .blockWidthAndHeightModifier(frameWidth, frameHeight)
    }
}

#Preview("NativeSpacer") {
    NativeSpacer(
        frameWidth: "notSet",
        frameHeight: "infinity"
    )
}
