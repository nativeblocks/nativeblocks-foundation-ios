import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable ZStack block for Nativeblocks.
///
/// `NativeZStack` allows you to stack child views on top of one another with alignment, spacing, padding,
/// and styling options. It supports click events and customizable layout.
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
    keyType: "nativeblocks/ZSTACK",
    description: "Nativeblocks ZStack block",
    version: 1
)
struct NativeZStack<Content: View>: View {
    // MARK: - Slot Properties

    /// The content of the ZStack, provided as a slot.
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

    /// The leading (left) padding inside the ZStack.
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

    /// The trailing (right) padding inside the ZStack.
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
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameWidth: String = "notSet"

    /// The height of the ZStack's frame.
    @NativeBlockProp(
        description: "The height of the ZStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameHeight: String = "notSet"

    // MARK: - Background and Styling Properties

    /// The background color of the ZStack.
    @NativeBlockProp(
        description: "The background color of the ZStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    /// The corner radius of the ZStack.
    @NativeBlockProp(
        description: "The corner radius of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var cornerRadius: CGFloat = 0

    /// The border color of the ZStack.
    @NativeBlockProp(
        description: "The border color of the ZStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the ZStack.
    @NativeBlockProp(
        description: "The border width of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    /// The shadow color of the ZStack.
    @NativeBlockProp(
        description: "The shadow color of the ZStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var shadowColor: Color = Color.black.opacity(0)

    /// The shadow radius of the ZStack.
    @NativeBlockProp(
        description: "The shadow radius of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal shadow offset of the ZStack.
    @NativeBlockProp(
        description: "The horizontal shadow offset of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowX: CGFloat = 0

    /// The vertical shadow offset of the ZStack.
    @NativeBlockProp(
        description: "The vertical shadow offset of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Properties

    /// Triggered when the ZStack is clicked.
    @NativeBlockEvent(description: "Triggered when the ZStack is clicked.")
    var onClick: (() -> Void)?

    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: alignmentHorizontal,
                vertical: alignmentVertical
            )
        ) {
            content(-1)
        }
        .blockWidthAndHeightModifier(
            frameWidth, frameHeight,
            alignment: Alignment(
                horizontal: alignmentHorizontal,
                vertical: alignmentVertical
            )
        )
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(
                cornerRadius:
                    cornerRadius
            ).stroke(
                borderColor,
                lineWidth: borderWidth
            )
        )
        .shadow(
            color: shadowColor,
            radius: shadowRadius, x: shadowX, y: shadowY
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
            onClick: {}
        )
    }
}
