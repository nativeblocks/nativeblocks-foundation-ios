import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable lazy vertical stack (LazyVStack) block for Nativeblocks.
///
/// `NativeLazyVStack` allows you to stack child views vertically with alignment, spacing, padding,
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
/// NativeLazyVStack(
///     content: { _ in
///          Text("Top Left Aligned")
///            .padding()
///     },
///     alignmentHorizontal: "center",
///     alignmentVertical: "top",
///     spacing: 10,
///     backgroundColor: "#ffffff",
///     onClick: { print("LazyVStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native LazyVStack",
    keyType: "NATIVE_LAZY_VSTACK",
    description: "Nativeblocks LazyVStack block",
    version: 1
)
struct NativeLazyVStack<Content: View>: View {
    @NativeBlockData(
        description:
            "A JSON array (e.g., '[{},{},...]') used for repeating the content based on its size. If the list value is invalid, the default content slot is invoked."
    )
    var list: String = ""
    // MARK: - Slot Properties

    /// The content of the LazyVStack, provided as a slot.
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

    /// The layout direction of the LazyVStack (LTR or RTL).
    @NativeBlockProp(
        description: "The layout direction of the LazyVStack.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "RTL"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction"),
        defaultValue: "LTR"
    )
    var direction: LayoutDirection = LayoutDirection.leftToRight

    // MARK: - Padding Properties

    /// The top padding inside the LazyVStack.
    @NativeBlockProp(
        description: "The top padding inside the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading (left) padding inside the LazyVStack.
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

    /// The trailing (right) padding inside the LazyVStack.
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
    var frameWidth: String = "notSet"

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
    var frameHeight: String = "notSet"

    // MARK: - Background and Styling Properties

    /// The background color of the LazyVStack.
    @NativeBlockProp(
        description: "The background color of the LazyVStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    /// The corner radius of the LazyVStack.
    @NativeBlockProp(
        description: "The corner radius of the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var cornerRadius: CGFloat = 0

    /// The border color of the LazyVStack.
    @NativeBlockProp(
        description: "The border color of the LazyVStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the LazyVStack.
    @NativeBlockProp(
        description: "The border width of the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    /// The shadow color of the LazyVStack.
    @NativeBlockProp(
        description: "The shadow color of the LazyVStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var shadowColor: Color = Color.black.opacity(0)

    /// The shadow radius of the LazyVStack.
    @NativeBlockProp(
        description: "The shadow radius of the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal shadow offset of the LazyVStack.
    @NativeBlockProp(
        description: "The horizontal shadow offset of the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowX: CGFloat = 0

    /// The vertical shadow offset of the LazyVStack.
    @NativeBlockProp(
        description: "The vertical shadow offset of the LazyVStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Properties

    /// Triggered when the LazyVStack is clicked.
    @NativeBlockEvent(description: "Triggered when the LazyVStack is clicked.")
    var onClick: () -> Void

    var body: some View {
        LazyVStack(
            alignment: alignmentHorizontal,
            spacing: spacing
        ) {
            if let listSize = list.listSize() {
                ForEach(0..<max(1, listSize), id: \.self) { index in
                    content(index)
                }
            } else {
                content(-1)
            }
        }
        .blockWidthAndHeightModifier(
            frameWidth,
            frameHeight,
            alignment: Alignment(
                horizontal: alignmentHorizontal,
                vertical: alignmentVertical)
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
        .environment(\.layoutDirection, direction)
        .onTapGesture {
            onClick()
        }
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
