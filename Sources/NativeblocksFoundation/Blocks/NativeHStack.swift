import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable HStack block for Nativeblocks.
///
/// `NativeHStack` is a flexible horizontal stack layout that integrates with the Nativeblocks ecosystem.
/// It supports features like customizable alignment, spacing, padding, colors, shadows, and more.
///
/// ### Features:
/// - Dynamic content defined using slots.
/// - Configurable alignment, direction, padding, and size.
/// - Background, border, and shadow styling options.
/// - Trigger actions on tap events.
///
/// ### Example:
/// ```swift
/// NativeHStack(
///     content: { _ in Text("Hello, World!") },
///     alignmentHorizontal: "center",
///     alignmentVertical: "center",
///     spacing: 10,
///     onClick: { print("HStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native HStack",
    keyType: "NATIVE_HSTACK",
    description: "Nativeblocks HStack block",
    version: 2
)
struct NativeHStack<Content: View>: View {
    @NativeBlockData(
        description:
            "A JSON array (e.g., '[{},{},...]') used for repeating the content based on its size. If the list value is invalid, the default content slot is invoked."
    )
    var list: String = ""

    // MARK: - Properties

    /// The content of the HStack, defined as a slot.
    @NativeBlockSlot(description: "The content displayed inside the HStack.")
    var content: (BlockIndex) -> Content

    // MARK: - Alignment Properties

    /// Horizontal alignment of the content in the HStack.
    /// - `valuePicker`: A dropdown picker for choosing alignment options.
    /// - `valuePickerOptions`: Contains options like "leading", "trailing", and "center".
    @NativeBlockProp(
        description: "Horizontal alignment of the HStack's content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "leading"

    /// Vertical alignment of the content in the HStack.
    /// - `valuePicker`: A dropdown picker for choosing vertical alignment options.
    /// - `valuePickerOptions`: Contains options like "top", "bottom", "center", and baselines.
    @NativeBlockProp(
        description: "Vertical alignment of the HStack's content.",
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

    /// Spacing between elements in the HStack.
    @NativeBlockProp(
        description: "Spacing between elements inside the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var spacing: CGFloat = 0

    // MARK: - Direction Property

    /// Layout direction of the HStack (LTR or RTL).
    /// - `valuePicker`: A dropdown picker for choosing the layout direction.
    /// - `valuePickerOptions`: Contains options like "LTR" (Left-to-Right) and "RTL" (Right-to-Left).
    @NativeBlockProp(
        description: "The layout direction of the HStack (Left-to-Right or Right-to-Left).",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "RTL"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction")
    )
    var direction: String = "LTR"

    // MARK: - Padding Properties

    /// Padding at the top of the HStack.
    @NativeBlockProp(
        description: "Padding at the top of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTop: CGFloat = 0

    /// Padding at the leading edge of the HStack.
    @NativeBlockProp(
        description: "Padding at the leading edge of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingLeading: CGFloat = 0

    /// Padding at the bottom of the HStack.
    @NativeBlockProp(
        description: "Padding at the bottom of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingBottom: CGFloat = 0

    /// Padding at the trailing edge of the HStack.
    @NativeBlockProp(
        description: "Padding at the trailing edge of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Size Properties

    @NativeBlockProp(
        description: "Width of the HStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameWidth: String = "notSet"

    @NativeBlockProp(
        description: "Height of the HStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameHeight: String = "notSet"

    // MARK: - Background Properties

    @NativeBlockProp(
        description: "Background color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#00000000"

    @NativeBlockProp(
        description: "Corner radius of the HStack's background.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var cornerRadius: CGFloat = 0

    @NativeBlockProp(
        description: "Border color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"

    @NativeBlockProp(
        description: "Border width of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderWidth: CGFloat = 0

    // MARK: - Shadow Properties

    /// Shadow color of the HStack.
    /// - `valuePicker`: A color picker for selecting the shadow color.
    @NativeBlockProp(
        description: "Shadow color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowColor: String = "#00000000"

    /// Shadow blur radius of the HStack.
    @NativeBlockProp(
        description: "Shadow blur radius of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowRadius: CGFloat = 0

    /// Horizontal offset of the HStack's shadow.
    @NativeBlockProp(
        description: "Horizontal offset of the HStack's shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowX: CGFloat = 0

    /// Vertical offset of the HStack's shadow.
    @NativeBlockProp(
        description: "Vertical offset of the HStack's shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Handlers

    /// Action triggered when the HStack is tapped.
    @NativeBlockEvent(
        description: "The action triggered when the HStack is tapped."
    )
    var onClick: (() -> Void)?

    // MARK: - Body

    var body: some View {
        HStack(
            alignment: mapBlockVerticalAlignment(alignmentVertical),
            spacing: spacing
        ) {
            let listArray = list.parseBlockList()
            if list != nil {
                ForEach(0..<max(1, listArray?.count ?? 0), id: \.self) { index in
                    content(index)
                }
            } else {
                content(-1)
            }
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
    NativeHStack(
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
        NativeHStack(
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
