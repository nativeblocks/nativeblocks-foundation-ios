import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable ZStack block for Nativeblocks.
///
/// `NativeZStack` allows you to stack child views on top of one another with alignment, spacing, padding,
/// and styling options. It supports click events and customizable layout direction.
///
/// ### Features:
/// - Customizable alignment (horizontal and vertical).
/// - Configurable padding, frame sizing, and background styling.
/// - Layout direction options (LTR or RTL).
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
    keyType: "NATIVE_ZSTACK",
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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "leading"

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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentVertical: String = "top"

    // MARK: - Layout Properties

    /// The spacing between child views in the ZStack.
    @NativeBlockProp(
        description: "The spacing between child views in the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var spacing: CGFloat = 0

    /// The layout direction of the ZStack (LTR or RTL).
    @NativeBlockProp(
        description: "The layout direction of the ZStack.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "RTL"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction")
    )
    var direction: String = "LTR"

    // MARK: - Padding Properties

    /// The top padding inside the ZStack.
    @NativeBlockProp(
        description: "The top padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTop: CGFloat = 0

    /// The leading (left) padding inside the ZStack.
    @NativeBlockProp(
        description: "The leading padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding inside the ZStack.
    @NativeBlockProp(
        description: "The bottom padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingBottom: CGFloat = 0

    /// The trailing (right) padding inside the ZStack.
    @NativeBlockProp(
        description: "The trailing padding inside the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
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
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
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
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameHeight: String = "notSet"

    // MARK: - Background and Styling Properties

    /// The background color of the ZStack.
    @NativeBlockProp(
        description: "The background color of the ZStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#00000000"

    /// The corner radius of the ZStack.
    @NativeBlockProp(
        description: "The corner radius of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var cornerRadius: CGFloat = 0

    /// The border color of the ZStack.
    @NativeBlockProp(
        description: "The border color of the ZStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"

    /// The border width of the ZStack.
    @NativeBlockProp(
        description: "The border width of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderWidth: CGFloat = 0

    /// The shadow color of the ZStack.
    @NativeBlockProp(
        description: "The shadow color of the ZStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowColor: String = "#00000000"

    /// The shadow radius of the ZStack.
    @NativeBlockProp(
        description: "The shadow radius of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal shadow offset of the ZStack.
    @NativeBlockProp(
        description: "The horizontal shadow offset of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowX: CGFloat = 0

    /// The vertical shadow offset of the ZStack.
    @NativeBlockProp(
        description: "The vertical shadow offset of the ZStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Properties

    /// Triggered when the ZStack is clicked.
    @NativeBlockEvent(description: "Triggered when the ZStack is clicked.")
    var onClick: (() -> Void)?

    var body: some View {
        ZStack(
            alignment: Alignment(
                horizontal: mapBlockAlignmentHorizontal(alignmentHorizontal),
                vertical: mapBlockVerticalAlignment(alignmentVertical)
            )
        ) {
            content(-1)
        }
        .blockWidthAndHeightModifier(
            frameWidth, frameHeight,
            alignment: Alignment(
                horizontal: mapBlockAlignmentHorizontal(alignmentHorizontal),
                vertical: mapBlockVerticalAlignment(alignmentVertical)
            )
        )
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .background(Color(blockHex: backgroundColor) ?? Color.black.opacity(0))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(
                cornerRadius:
                    cornerRadius
            ).stroke(
                Color(blockHex: borderColor) ?? Color.black.opacity(0),
                lineWidth: borderWidth
            )
        )
        .shadow(
            color: Color(blockHex: shadowColor) ?? Color.black.opacity(0),
            radius: shadowRadius, x: shadowX, y: shadowY
        )
        .blockDirection(direction)
        .onTapGesture {
            onClick?()
        }
        .disabled(onClick == nil)
    }
}

#Preview("Simple") {
    NativeZStack(
        content: { _ in
            Text("Text 1")
        },
        alignmentHorizontal: "leading",
        alignmentVertical: "top",
        spacing: 0,
        direction: "LTR",
        paddingTop: 0,
        paddingLeading: 0,
        paddingBottom: 0,
        paddingTrailing: 0,
        frameWidth: "notSet",
        frameHeight: "notSet",
        backgroundColor: "#00000000",
        cornerRadius: 0,
        borderColor: "#00000000",
        borderWidth: 0,
        shadowColor: "#00000000",
        shadowRadius: 0,
        shadowX: 0,
        shadowY: 0,
        onClick: {}
    )
}

#Preview("with Pading") {
    ZStack {
        NativeZStack(
            content: { _ in
                Text("Top Left Aligned")
                    .padding()
            },
            alignmentHorizontal: "trailing",
            alignmentVertical: "center",
            spacing: 0,
            direction: "LTR",
            paddingTop: 8,
            paddingLeading: 8,
            paddingBottom: 8,
            paddingTrailing: 8,
            frameWidth: "300",
            frameHeight: "200",
            backgroundColor: "#ff0000ff",
            cornerRadius: 30,
            borderColor: "#ff000000",
            borderWidth: 5,
            shadowColor: "#ff000000",
            shadowRadius: 30,
            shadowX: 7,
            shadowY: 7,
            onClick: {}
        )
    }
    .padding(10)
    .background(Color.blue)
}
