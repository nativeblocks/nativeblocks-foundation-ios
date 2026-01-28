import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable spacer block for Nativeblocks.
///
/// `NativeSpacer` provides a flexible and configurable spacer to create adjustable spacing in layouts.
/// It can be used to define gaps with customizable dimensions and grow behavior.
///
/// ### Features:
/// - Configurable width and height.
/// - Supports fixed or flexible sizes.
///
/// ### Example:
/// ```swift
/// NativeSpacer(
///     frameWidth: "fill",
///     frameHeight: "auto"
/// )
/// ```
@NativeBlock(
    name: "Native Spacer",
    keyType: "nativeblocks/spacer",
    description: "Nativeblocks spacer block",
    version: 2,
    versionName: "2"
)
struct NativeSpacer: View {
    var blockProps: BlockProps? = nil
    // MARK: - Frame Properties

    /// The width of the Spacer frame.
    @NativeBlockProp(
        description: "The width of the Spacer frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// The height of the Spacer frame.
    @NativeBlockProp(
        description: "The height of the Spacer frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"

    var body: some View {
        Spacer().blockWidthAndHeightModifier(width, height)

    }
}

#Preview("NativeSpacer") {
    NativeSpacer(
        width: "auto",
        height: "fill"
    )
}
