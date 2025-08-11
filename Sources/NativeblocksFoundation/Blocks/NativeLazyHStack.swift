import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable LazyHStack block for Nativeblocks.
///
/// `NativeLazyHStack` is a flexible horizontal stack layout that integrates with the Nativeblocks ecosystem.
/// It supports features like customizable alignment, spacing, padding, colors, and more.
///
/// ### Features:
/// - Dynamic content defined using slots.
/// - Configurable alignment, padding, and size.
/// - Background, border and styling options.
///
/// ### Example:
/// ```swift
/// NativeLazyHStack(
///     content: { _ in Text("Hello, World!") },
///     alignmentHorizontal: "center",
///     alignmentVertical: "center",
///     spacing: 10,
/// )
/// ```
@NativeBlock(
    name: "Native LazyHStack",
    keyType: "nativeblocks/lazy_hstack",
    description: "Nativeblocks LazyHStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeLazyHStack<Content: View>: View {
    var blockProps: BlockProps? = nil

    /// Length of list
    @NativeBlockData(
        description: "Length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Properties

    /// The content displayed inside the LazyHStack.
    @NativeBlockSlot(description: "The content displayed inside the LazyHStack.")
    var content: (BlockIndex) -> Content

    // MARK: - Alignment Properties

    /// Vertical alignment of the LazyHStack's content.
    /// - `valuePicker`: A dropdown picker for choosing vertical alignment options.
    /// - `valuePickerOptions`: Contains options like "top", "bottom", "center", and baselines.
    @NativeBlockProp(
        description: "Vertical alignment of the LazyHStack's content.",
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
    var alignmentVertical: VerticalAlignment = VerticalAlignment.top

    /// Spacing between elements inside the LazyHStack.
    @NativeBlockProp(
        description: "Spacing between elements inside the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "0"
    )
    var spacing: CGFloat = 0

    // MARK: - Padding Properties

    /// Padding at the top of the LazyHStack.
    @NativeBlockProp(
        description: "Padding at the top of the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// Padding at the leading edge of the LazyHStack.
    @NativeBlockProp(
        description: "Padding at the leading edge of the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// Padding at the bottom of the LazyHStack.
    @NativeBlockProp(
        description: "Padding at the bottom of the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// Padding at the trailing edge of the LazyHStack.
    @NativeBlockProp(
        description: "Padding at the trailing edge of the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Size Properties

    /// Width of the LazyHStack frame
    @NativeBlockProp(
        description: "Width of the LazyHStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// Height of the LazyHStack frame
    @NativeBlockProp(
        description: "Height of the LazyHStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"
    // MARK: - Background Properties

    /// Background color of the LazyHStack
    @NativeBlockProp(
        description: "Background color of the LazyHStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    /// Top-start corner radius.
    @NativeBlockProp(
        description: "Top-start corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Radius"),
        defaultValue: "0.0"
    )
    var radiusTopStart: CGFloat = 0.0

    /// Top-end corner radius.
    @NativeBlockProp(
        description: "Top-end corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Radius"),
        defaultValue: "0.0"
    )
    var radiusTopEnd: CGFloat = 0.0

    /// Bottom-start corner radius.
    @NativeBlockProp(
        description: "Bottom-start corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Radius"),
        defaultValue: "0.0"
    )
    var radiusBottomStart: CGFloat = 0.0

    /// Bottom-end corner radius.
    @NativeBlockProp(
        description: "Bottom-end corner radius.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Radius"),
        defaultValue: "0.0"
    )
    var radiusBottomEnd: CGFloat = 0.0

    /// Border color of the HStack
    @NativeBlockProp(
        description: "Border color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Radius"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// Border width of the LazyHStack
    @NativeBlockProp(
        description: "Border width of the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Radius"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Body

    var body: some View {
        LazyHStack(alignment: alignmentVertical, spacing: spacing) {
            if length >= 0 {
                ForEach(0..<length, id: \.self) { index in
                    content(index)
                }
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
    }
}

struct NativeLazyHStack_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeLazyHStack(
            content: { _ in
                Text("Text 1")
            }
        )
    }
}

struct NativeLazyHStack_Padding_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeLazyHStack(
            length: 5,
            content: { index in
                if index == 0 {
                    Text("index:\(index)")
                        .background(Color.cyan)
                } else if index == 1 {
                    Text("index:\(index)")
                        .background(Color.black)
                } else {
                    Text("index:\(index)")
                        .background(Color.red)
                }
            },
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
        ).padding(10)
            .background(Color.blue)
    }
}
