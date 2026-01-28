import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable vertical stack (VStack) block for Nativeblocks.
///
/// `NativeVStack` is a flexible vertical stack layout that integrates with the Nativeblocks ecosystem.
/// It supports features like customizable alignment, spacing, padding, colors, and more.
///
/// ### Features:
/// - Customizable alignment (horizontal and vertical).
/// - Configurable spacing between child views.
/// - Support for padding, frame sizing, and background styling.
/// - Shadow and border customization.
///
/// ### Example:
/// ```swift
/// NativeVStack(
///     content: { _ in
///          Text("Top Left Aligned")
///            .padding()
///     },
///     alignmentHorizontal: "center",
///     spacing: 10,
///     backgroundColor: "#ffffff",
///     onClick: { print("VStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native VStack",
    keyType: "nativeblocks/vstack",
    description: "Nativeblocks VStack block",
    version: 2,
    versionName: "2"
)
struct NativeVStack<Content: View>: View {
    var blockProps: BlockProps? = nil

    /// Length of list
    @NativeBlockData(
        description: "Length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Slot Properties

    /// The content to display inside the VStack.
    @NativeBlockSlot(description: "The content to display inside the VStack.")
    var content: (BlockIndex) -> Content

    // MARK: - Alignment Properties

    /// The horizontal alignment of the VStack's content.
    @NativeBlockProp(
        description: "The horizontal alignment of the VStack's content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "leading"
    )
    var alignmentHorizontal: HorizontalAlignment = .leading

    // MARK: - Layout Properties

    /// The spacing between child views in the VStack.
    @NativeBlockProp(
        description: "The spacing between child views in the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "0"
    )
    var spacing: CGFloat = 0

    // MARK: - Padding Properties

    /// The top padding inside the VStack.
    @NativeBlockProp(
        description: "The top padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading padding inside the VStack..
    @NativeBlockProp(
        description: "The leading padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding inside the VStack.
    @NativeBlockProp(
        description: "The bottom padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// The trailing padding inside the VStack.
    @NativeBlockProp(
        description: "The trailing padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Frame Properties

    /// The width of the VStack's frame.
    @NativeBlockProp(
        description: "The width of the VStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// The height of the VStack's frame.
    @NativeBlockProp(
        description: "The height of the VStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"

    // MARK: - Background and Styling Properties

    /// The background color of the VStack.
    @NativeBlockProp(
        description: "The background color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

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

    /// The border color of the VStack.
    @NativeBlockProp(
        description: "The border color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the VStack.
    @NativeBlockProp(
        description: "The border width of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Event Properties

    /// Action triggered when the VStack is tapped.
    @NativeBlockEvent(description: "Action triggered when the VStack is tapped.")
    var onClick: (() -> Void)?

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: alignmentHorizontal, spacing: spacing) {
                content(-1)
            }
        }
        .blockWidthAndHeightModifier(width, height)
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .background(backgroundColor)
        .clipShape(
            CornerRadiusShape(
                topLeft: radiusTopStart,
                topRight: radiusTopEnd,
                bottomLeft: radiusBottomStart,
                bottomRight: radiusBottomEnd
            )
        )
        .overlay(
            CornerRadiusShape(
                topLeft: radiusTopStart,
                topRight: radiusTopEnd,
                bottomLeft: radiusBottomStart,
                bottomRight: radiusBottomEnd
            )
            .stroke(borderColor, lineWidth: borderWidth)
        )
        .blockOnTapGesture(enable: onClick != nil) {
            onClick?()
        }
    }
}
