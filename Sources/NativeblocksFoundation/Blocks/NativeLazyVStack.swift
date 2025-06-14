import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable lazy vertical stack (LazyVStack) block for Nativeblocks.
///
/// `LazyVStack` is a flexible vertical stack layout that integrates with the Nativeblocks ecosystem.
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
/// NativeLazyVStack(
///     content: { _ in
///          Text("Top Left Aligned")
///            .padding()
///     },
///     alignmentHorizontal: "center",
///     alignmentVertical: "top",
///     spacing: 10,
///     backgroundColor: "#ffffff",
/// )
/// ```
@NativeBlock(
    name: "Native LazyVStack",
    keyType: "nativeblocks/LAZY_VSTACK",
    description: "Nativeblocks LazyVStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeLazyVStack<Content: View>: View {
    var blockProps: BlockProps? = nil

    /// Length of list
    @NativeBlockData(
        description: "Length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Slot Properties

    /// The content to display inside the LazyVStack.
    @NativeBlockSlot(description: "The content to display inside the LazyVStack.")
    var content: (BlockIndex) -> Content

    // MARK: - Alignment Properties

    /// The horizontal alignment of the LazyVStack's content.
    @NativeBlockProp(
        description: "The horizontal alignment of the LazyVStack's content.",
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

    /// The vertical alignment of the LazyVStack's content.
    @NativeBlockProp(
        description: "The vertical alignment of the LazyVStack's content.",
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

    /// The spacing between child views in the LazyVStack.
    @NativeBlockProp(
        description: "The spacing between child views in the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "0"
    )
    var spacing: CGFloat = 0

    // MARK: - Padding Properties

    /// The top padding inside the LazyVStack.
    @NativeBlockProp(
        description: "The top padding inside the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading padding inside the LazyVStack..
    @NativeBlockProp(
        description: "The leading padding inside the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding inside the LazyVStack.
    @NativeBlockProp(
        description: "The bottom padding inside the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// The trailing padding inside the LazyVStack.
    @NativeBlockProp(
        description: "The trailing padding inside the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Frame Properties

    /// The width of the LazyVStack's frame.
    @NativeBlockProp(
        description: "The width of the LazyVStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var width: String = "notSet"

    /// The height of the LazyVStack's frame.
    @NativeBlockProp(
        description: "The height of the LazyVStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var height: String = "notSet"

    // MARK: - Background and Styling Properties

    /// The background color of the LazyVStack.
    @NativeBlockProp(
        description: "The background color of the LazyVStack.",
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
    
    /// The border color of the LazyVStack.
    @NativeBlockProp(
        description: "The border color of the LazyVStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the LazyVStack.
    @NativeBlockProp(
        description: "The border width of the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Event Properties

    /// Action triggered when the LazyVStack is tapped.
    @NativeBlockEvent(description: "Action triggered when the LazyVStack is tapped.")
    var onClick: (() -> Void)?

    // MARK: - Event Properties

    var body: some View {
        LazyVStack(alignment: alignmentHorizontal, spacing: spacing) {
            if length >= 0 {
                ForEach(0..<length, id: \.self) { index in
                    content(index)
                }
            }
        }
        .blockWidthAndHeightModifier(width, height, alignment: Alignment(horizontal: alignmentHorizontal, vertical: alignmentVertical))
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

struct NativeLazyVStack_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeLazyVStack(
            content: { _ in
                Text("Text 1")
            },
            onClick: {}
        )
    }
}
