import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable LazyHStack block for Nativeblocks.
///
/// `NativeLazyHStack` is a flexible horizontal stack layout that integrates with the Nativeblocks ecosystem.
/// It supports features like customizable alignment, spacing, padding, colors, shadows, and more.
///
/// ### Features:
/// - Dynamic content defined using slots.
/// - Configurable alignment, padding, and size.
/// - Background, border, and shadow styling options.
/// - Trigger actions on tap events.
///
/// ### Example:
/// ```swift
/// NativeLazyHStack(
///     content: { _ in Text("Hello, World!") },
///     alignmentHorizontal: "center",
///     alignmentVertical: "center",
///     spacing: 10,
///     onClick: { print("LazyHStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native LazyHStack",
    keyType: "nativeblocks/LAZY_HSTACK",
    description: "Nativeblocks LazyHStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeLazyHStack<Content: View>: View {
    var blockProps: BlockProps? = nil
    @NativeBlockData(
        description: "length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Properties

    /// The content of the LazyHStack, defined as a slot.
    @NativeBlockSlot(description: "The content displayed inside the LazyHStack.")
    var content: (BlockIndex) -> Content

    // MARK: - Alignment Properties

    /// Horizontal alignment of the content in the LazyHStack.
    /// - `valuePicker`: A dropdown picker for choosing alignment options.
    /// - `valuePickerOptions`: Contains options like "leading", "trailing", and "center".
    @NativeBlockProp(
        description: "Horizontal alignment of the LazyHStack's content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "leading"
    )
    var alignmentHorizontal: HorizontalAlignment = HorizontalAlignment.leading

    /// Vertical alignment of the content in the LazyHStack.
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

    /// Spacing between elements in the LazyHStack.
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

    @NativeBlockProp(
        description: "Width of the LazyHStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameWidth: String = "notSet"

    @NativeBlockProp(
        description: "Height of the LazyHStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameHeight: String = "notSet"
    @NativeBlockProp(
        description: "Weight of the layout in HStack or VStack. Default is 0 means not set.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0"
    )
    var frameWeight: CGFloat = 0
    // MARK: - Background Properties

    @NativeBlockProp(
        description: "Background color of the LazyHStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    @NativeBlockProp(
        description: "Corner radius of the LazyHStack's background.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var cornerRadius: CGFloat = 0

    @NativeBlockProp(
        description: "Border color of the LazyHStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    @NativeBlockProp(
        description: "Border width of the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Shadow Properties

    /// Shadow color of the LazyHStack.
    /// - `valuePicker`: A color picker for selecting the shadow color.
    @NativeBlockProp(
        description: "Shadow color of the LazyHStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var shadowColor: Color = Color.black.opacity(0)

    /// Shadow blur radius of the LazyHStack.
    @NativeBlockProp(
        description: "Shadow blur radius of the LazyHStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowRadius: CGFloat = 0

    /// Horizontal offset of the LazyHStack's shadow.
    @NativeBlockProp(
        description: "Horizontal offset of the LazyHStack's shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowX: CGFloat = 0

    /// Vertical offset of the LazyHStack's shadow.
    @NativeBlockProp(
        description: "Vertical offset of the LazyHStack's shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Handlers

    /// Action triggered when the LazyHStack is tapped.
    @NativeBlockEvent(
        description: "The action triggered when the LazyHStack is tapped."
    )
    var onClick: () -> Void

    // MARK: - Body

    var body: some View {
        LazyHStack(
            alignment: alignmentVertical,
            spacing: spacing
        ) {
            if length >= 0 {
                ForEach(0..<length, id: \.self) { index in
                    content(index)
                }
            } else {
                content(-1)
            }
        }
        .blockWidthAndHeightModifier(
            frameWidth, frameHeight,
            alignment: Alignment(
                horizontal: alignmentHorizontal,
                vertical: alignmentVertical
            )
        )
        .weighted(frameWeight, proxy: blockProps?.hierarchy?.last?.scope)
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
        .onTapGesture {
            onClick()
        }
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
            },
            onClick: {}
        )
    }
}

struct NativeLazyHStack_Padding_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        ZStack {
            NativeLazyHStack(
                content: { _ in
                    Text("Top Left Aligned")
                        .padding()
                },
                alignmentHorizontal: HorizontalAlignment.leading,
                alignmentVertical: VerticalAlignment.center,
                paddingTop: 8,
                paddingLeading: 8,
                paddingBottom: 8,
                paddingTrailing: 8,
                frameWidth: "300",
                frameHeight: "200",
                backgroundColor: Color.blue,
                cornerRadius: 30,
                borderColor: Color.black,
                borderWidth: 5,
                shadowColor: Color.black,
                shadowRadius: 30,
                shadowX: 7,
                shadowY: 7,
                onClick: {}
            )
        }
        .padding(10)
        .background(Color.blue)
    }
}
