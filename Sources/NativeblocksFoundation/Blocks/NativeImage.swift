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
    keyType: "nativeblocks/image",
    description: "Nativeblocks image block",
    version: 1,
    versionName: "1.0.0"
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
    ///   - "auto": Default behavior without resizing.
    ///   - "stretch": Stretches the image to fit its frame.
    ///   - "tile": Tiles the image across its frame.
    @NativeBlockProp(
        description: "The resizing mode for the image.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("stretch", "stretch"),
            NativeBlockValuePickerOption("tile", "tile"),
        ],
        defaultValue: "stretch"
    )
    var resizable: String = "stretch"

    // MARK: - Size Properties

    /// Width of the image frame
    @NativeBlockProp(
        description: "Width of the image frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// Height of the image frame
    @NativeBlockProp(
        description: "Height of the image frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"
    
    /// Weight of the layout in HStack or VStack. Default is 0 means not set
    @NativeBlockProp(
        description: "Weight of the layout in HStack or VStack. Default is 0 means not set.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0"
    )
    var weight: CGFloat = 0
    
    // MARK: - Border Properties
    
    /// Top-start corner radius.
    @NativeBlockProp(
        description: "Top-start corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0.0"
    )
    var radiusTopStart: CGFloat = 0.0
    
    /// Top-end corner radius.
    @NativeBlockProp(
        description: "Top-end corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0.0"
    )
    var radiusTopEnd: CGFloat = 0.0
    
    /// Bottom-start corner radius.
    @NativeBlockProp(
        description: "Bottom-start corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0.0"
    )
    var radiusBottomStart: CGFloat = 0.0
    
    /// Bottom-end corner radius.
    @NativeBlockProp(
        description: "Bottom-end corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0.0"
    )
    var radiusBottomEnd: CGFloat = 0.0
    
    /// Border color of the HStack.
    @NativeBlockProp(
        description: "Border color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// Border width of the HStack.
    @NativeBlockProp(
        description: "Border width of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Event Handlers

    /// Action triggered when the HStack is tapped.
    @NativeBlockEvent(
        description: "Action triggered when the HStack is tapped."
    )
    var onClick: (() -> Void)?

    // MARK: - Body

    var body: some View {
        let shape = CornerRadiusShape(
            topLeft: radiusTopStart,
            topRight: radiusTopEnd,
            bottomLeft: radiusBottomStart,
            bottomRight: radiusBottomEnd
        )

        if imageUrl.isValidImageUrl() {
            KFImage(URL(string: imageUrl))
                .placeholder {
                    placeHolder(-1)
                }
                .resizable()
                .blockResizable(resizable)
                .blockScaled(contentMode)
                .blockWidthAndHeightModifier(width, height)
                .weighted(weight, proxy: blockProps?.hierarchy?.last?.scope)
                .contentShape(shape)
                .clipShape(shape)
                .accessibility(label: Text(contentDescription))
                .blockOnTapGesture(enable: onClick != nil) {
                    onClick?()
                }
        } else {
            errorView(-1)
        }
    }
}
