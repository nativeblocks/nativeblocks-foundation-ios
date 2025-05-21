import Kingfisher
import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable image block for Nativeblocks.
///
/// `NativeImage` is a flexible image block for displaying images with customization options,
/// including placeholders, error handling, resizing, scaling, and styling.
///
/// ### Features:
/// - Supports image loading from remote URLs.
/// - Customizable placeholder and error views.
/// - Configurable resizing and scaling options.
/// - Background styling, corner radius, and accessibility support.
///
/// ### Example:
/// ```swift
/// NativeImage(
///     imageUrl: "https://example.com/image.png",
///     placeHolder: { _ in Text("Loading...") },
///     errorView: { _ in Text("Failed to load image.") },
///     contentDescription: "Example image",
///     contentMode: "fit",
///     resizable: "stretch"
/// )
/// ```
@NativeBlock(
    name: "Native Image",
    keyType: "nativeblocks/IMAGE",
    description: "Nativeblocks image block",
    version: 1
)
struct NativeImage<Content: View>: View {
    var blockProps: BlockProps? = nil
    // MARK: - Data Properties

    /// The URL of the image to display.
    @NativeBlockData(description: "The URL of the image to display.")
    var imageUrl: String

    // MARK: - Slot Properties

    /// A placeholder view to display while the image is loading.
    @NativeBlockSlot(description: "The placeholder view displayed while the image is loading.")
    var placeHolder: (BlockIndex) -> Content

    /// A view to display if there is an error loading the image.
    @NativeBlockSlot(description: "The error view displayed when the image fails to load.")
    var errorView: (BlockIndex) -> Content

    /// A description of the image for accessibility purposes.
    @NativeBlockData(description: "The content description for the image, used for accessibility.")
    var contentDescription: String = ""

    // MARK: - Resizing and Scaling Properties

    /// The content mode for scaling the image.
    /// - `valuePicker`: A dropdown picker for selecting the content mode.
    /// - `valuePickerOptions`: Options include "fill" (scale to fill the frame) and "fit" (scale to fit the frame).
    @NativeBlockProp(
        description: "The content mode for scaling the image.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("fill", "fill"),
            NativeBlockValuePickerOption("fit", "fit"),
        ],
        defaultValue: "fit"
    )
    var contentMode: String = "fit"

    /// The resizing mode for the image.
    /// - `valuePicker`: A dropdown picker for selecting the resizing mode.
    /// - `valuePickerOptions`: Options include:
    ///   - "notSet": Default behavior without resizing.
    ///   - "stretch": Stretches the image to fit its frame.
    ///   - "tile": Tiles the image across its frame.
    @NativeBlockProp(
        description: "The resizing mode for the image.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("stretch", "stretch"),
            NativeBlockValuePickerOption("tile", "tile"),
        ],
        defaultValue: "stretch"
    )
    var resizable: String = "stretch"

    // MARK: - Size Properties

    /// The width of the image frame.
    /// - `valuePicker`: A combobox input for specifying width options.
    /// - `valuePickerOptions`: Options include:
    ///   - "notSet": Default behavior without specific width.
    ///   - "infinity": Stretches the width to fill available space.
    @NativeBlockProp(
        description: "The width of the image frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameWidth: String = "notSet"

    /// The height of the image frame.
    /// - `valuePicker`: A combobox input for specifying height options.
    /// - `valuePickerOptions`: Options include:
    ///   - "notSet": Default behavior without specific height.
    ///   - "infinity": Stretches the height to fill available space.
    @NativeBlockProp(
        description: "The height of the image frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameHeight: String = "notSet"
    @NativeBlockProp(
        description: "Weight of the layout in HStack or VStack. Default is 0 means not set.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0"
    )
    var frameWeight: CGFloat = 0
    // MARK: - Background Properties

    /// The background color of the image.
    /// - `valuePicker`: A color picker for selecting the background color.
    @NativeBlockProp(
        description: "The background color of the image.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    /// The corner radius of the image for rounded corners.
    /// - `valuePicker`: A number input for specifying the radius.
    @NativeBlockProp(
        description: "The corner radius of the image for rounded corners.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var cornerRadius: CGFloat = 0

    // MARK: - Body

    var body: some View {
        let shape = roundedRectangleShape(cornerRadius)

        if imageUrl.isValidImageUrl() {
            KFImage(URL(string: imageUrl))
                .placeholder {
                    placeHolder(-1)
                }
                .resizable()
                .blockResizable(resizable)
                .blockScaled(contentMode)
                .blockWidthAndHeightModifier(frameWidth, frameHeight)
                .weighted(frameWeight, proxy: blockProps?.hierarchy?.last?.scope)
                .contentShape(.rect)
                .background(backgroundColor)
                .clipShape(shape)
                .accessibility(label: Text(contentDescription))
        } else {
            errorView(-1)
        }
    }
}
