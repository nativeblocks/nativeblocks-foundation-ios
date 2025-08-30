import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable ZStack block for Nativeblocks.
///
/// `NativeZStack` is a flexible z-index stack layout that integrates with the Nativeblocks ecosystem.
/// It supports features like customizable alignment, spacing, padding, colors, and more.
///
/// ### Features:
/// - Customizable alignment (horizontal and vertical).
/// - Configurable padding, frame sizing, and background styling.
/// - Shadow and border customization.
///
/// ### Example:
/// ```swift
/// NativeZStack(
///     content: { _ in
///          Text("Top Left Aligned")
///            .padding()
///     },
///     alignmentHorizontal: "center",
///     alignmentVertical: "top",
///     backgroundColor: "#ffffff",
///     onClick: { print("ZStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native ZStack",
    keyType: "nativeblocks/zstack",
    description: "Nativeblocks ZStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeZStack<Content: View>: View {
    var blockProps: BlockProps? = nil
    // MARK: - Slot Properties

    /// The content to display inside the ZStack.
    @NativeBlockSlot(description: "The content to display inside the ZStack.")
    var content: (BlockIndex) -> Content

    // MARK: - Alignment Properties

    /// The horizontal alignment of the ZStack's content.
    @NativeBlockProp(
        description: "The horizontal alignment of the ZStack's content.",
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

    /// The vertical alignment of the ZStack's content.
    @NativeBlockProp(
        description: "The vertical alignment of the ZStack's content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
            NativeBlockValuePickerOption("lastTextBaseline", "lastTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "top"
    )
    var alignmentVertical: VerticalAlignment = .top

    // MARK: - Layout Properties

    /// The spacing between child views in the ZStack.
    @NativeBlockProp(
        description: "The spacing between child views in the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "0"
    )
    var spacing: CGFloat = 0

    // MARK: - Padding Properties

    /// The top padding inside the ZStack.
    @NativeBlockProp(
        description: "The top padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading padding inside the ZStack.
    @NativeBlockProp(
        description: "The leading padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding inside the ZStack.
    @NativeBlockProp(
        description: "The bottom padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// The trailing padding inside the ZStack.
    @NativeBlockProp(
        description: "The trailing padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Frame Properties

    /// The width of the ZStack's frame.
    @NativeBlockProp(
        description: "The width of the ZStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// The height of the ZStack's frame.
    @NativeBlockProp(
        description: "The height of the ZStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"

    /// Weight of the layout in HStack or VStack. Default is 0 means not set.
    @NativeBlockProp(
        description: "Weight of the layout in HStack or VStack. Default is 0 means not set.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0.0"
    )
    var weight: CGFloat = 0.0

    // MARK: - Background and Styling Properties

    /// The background color of the ZStack.
    @NativeBlockProp(
        description: "The background color of the ZStack.",
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

    /// The border color of the ZStack.
    @NativeBlockProp(
        description: "The border color of the ZStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the ZStack.
    @NativeBlockProp(
        description: "The border width of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Event Properties

    /// Action triggered when the ZStack is tapped.
    @NativeBlockEvent(description: "Action triggered when the ZStack is tapped.")
    var onClick: (() -> Void)?

    var body: some View {
        ZStack(alignment: Alignment(horizontal: alignmentHorizontal, vertical: alignmentVertical)) {
            content(-1)
        }
        .blockWidthAndHeightModifier(width, height)
        .weighted(weight, proxy: blockProps?.hierarchy.last?.scope)
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

struct NativeZStack_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeZStack(
            content: { _ in
                Text("Text 1")
            },
            alignmentHorizontal: HorizontalAlignment.center,
            alignmentVertical: VerticalAlignment.center,
            spacing: 0,
            paddingTop: 8,
            paddingLeading: 8,
            paddingBottom: 8,
            paddingTrailing: 8,
            width: "300",
            height: "200",
            backgroundColor: Color.blue,
            radiusTopStart: 0,
            radiusTopEnd: 0,
            radiusBottomStart: 0,
            radiusBottomEnd: 0,
            borderColor: Color.black,
            borderWidth: 5,
            onClick: {}
        ).padding(10)
            .background(Color.blue)
    }
}
