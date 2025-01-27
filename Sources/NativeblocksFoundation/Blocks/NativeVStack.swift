import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable vertical stack (VStack) block for Nativeblocks.
///
/// `NativeVStack` allows you to stack child views vertically with alignment, spacing, padding,
/// and styling options. It also supports click events and customizable layout direction.
///
/// ### Features:
/// - Customizable alignment (horizontal and vertical).
/// - Configurable spacing between child views.
/// - Support for padding, frame sizing, and background styling.
/// - Layout direction options (LTR or RTL).
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
///     alignmentVertical: "top",
///     spacing: 10,
///     backgroundColor: "#ffffff",
///     onClick: { print("VStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native VStack",
    keyType: "NATIVE_VSTACK",
    description: "Nativeblocks VStack block",
    version: 1
)
struct NativeVStack<Content: View>: View {
    // MARK: - Slot Properties

    /// The content of the VStack, provided as a slot.
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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "leading"

    /// The vertical alignment of the VStack's content.
    @NativeBlockProp(
        description: "The vertical alignment of the VStack's content.",
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

    /// The spacing between child views in the VStack.
    @NativeBlockProp(
        description: "The spacing between child views in the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var spacing: CGFloat = 0

    /// The layout direction of the VStack (LTR or RTL).
    @NativeBlockProp(
        description: "The layout direction of the VStack.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "RTL"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction")
    )
    var direction: String = "LTR"

    // MARK: - Padding Properties

    /// The top padding inside the VStack.
    @NativeBlockProp(
        description: "The top padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTop: CGFloat = 0

    /// The leading (left) padding inside the VStack.
    @NativeBlockProp(
        description: "The leading padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding inside the VStack.
    @NativeBlockProp(
        description: "The bottom padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingBottom: CGFloat = 0

    /// The trailing (right) padding inside the VStack.
    @NativeBlockProp(
        description: "The trailing padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Frame Properties

    /// The width of the VStack's frame.
    @NativeBlockProp(
        description: "The width of the VStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameWidth: String = "notSet"

    /// The height of the VStack's frame.
    @NativeBlockProp(
        description: "The height of the VStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameHeight: String = "notSet"

    // MARK: - Background and Styling Properties

    /// The background color of the VStack.
    @NativeBlockProp(
        description: "The background color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#00000000"

    /// The corner radius of the VStack.
    @NativeBlockProp(
        description: "The corner radius of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var cornerRadius: CGFloat = 0

    /// The border color of the VStack.
    @NativeBlockProp(
        description: "The border color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"

    /// The border width of the VStack.
    @NativeBlockProp(
        description: "The border width of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderWidth: CGFloat = 0

    /// The shadow color of the VStack.
    @NativeBlockProp(
        description: "The shadow color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowColor: String = "#00000000"

    /// The shadow radius of the VStack.
    @NativeBlockProp(
        description: "The shadow radius of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal shadow offset of the VStack.
    @NativeBlockProp(
        description: "The horizontal shadow offset of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowX: CGFloat = 0

    /// The vertical shadow offset of the VStack.
    @NativeBlockProp(
        description: "The vertical shadow offset of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Properties

    /// Triggered when the VStack is clicked.
    @NativeBlockEvent(description: "Triggered when the VStack is clicked.")
    var onClick: (() -> Void)?

    var body: some View {
        VStack(
            alignment: mapBlockAlignmentHorizontal(alignmentHorizontal),
            spacing: spacing
        ) {
            content(-1)
        }
        .blockWidthAndHeightModifier(
            frameWidth,
            frameHeight,
            alignment: Alignment(
                horizontal: mapBlockAlignmentHorizontal(alignmentHorizontal),
                vertical: mapBlockVerticalAlignment(alignmentVertical))
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
    NativeVStack(
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
        NativeVStack(
            content: { _ in
                Text("Top Left Aligned")
                    .padding()
            },
            alignmentHorizontal: "leading",
            alignmentVertical: "top",
            spacing: 0,
            direction: "LRT",
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
