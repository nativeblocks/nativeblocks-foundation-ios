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
///     frameWidth: "infinity",
///     frameHeight: "notSet"
/// )
/// ```
@NativeBlock(
    name: "Native Spacer",
    keyType: "NATIVE_SPACER",
    description: "Nativeblocks spacer block",
    version: 1
)
struct NativeSpacer: View {
    // MARK: - Frame Properties

    /// The width of the spacer.
    ///
    /// The `frameWidth` determines how the spacer behaves horizontally. It can either have a fixed value,
    /// be infinite to grow within its container, or be unset (`notSet`) to rely on the layout's default behavior.
    @NativeBlockProp(
        description: "The width of the spacer. It can be a fixed value, infinite, or not set.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameWidth: String = "notSet"

    /// The height of the spacer.
    ///
    /// The `frameHeight` determines how the spacer behaves vertically. It can either have a fixed value,
    /// be infinite to grow within its container, or be unset (`notSet`) to rely on the layout's default behavior.
    @NativeBlockProp(
        description: "The height of the spacer. It can be a fixed value, infinite, or not set.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
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
