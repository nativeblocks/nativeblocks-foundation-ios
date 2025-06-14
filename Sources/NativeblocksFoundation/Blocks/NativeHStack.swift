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
/// - Configurable alignment, padding, and size.
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
    keyType: "nativeblocks/HSTACK",
    description: "Nativeblocks HStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeHStack<Content: View>: View {
    private let proxy = WeightedProxy(kind: .horizontal)
    @State private var initialized = false
    var blockProps: BlockProps? = nil
    @NativeBlockData(
        description: "length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Properties

    /// The content of the HStack, defined as a slot.
    @NativeBlockSlot(description: "The content displayed inside the HStack.")
    var content: (BlockIndex, Any) -> Content

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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "leading"
    )
    var alignmentHorizontal: HorizontalAlignment = HorizontalAlignment.leading

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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "top"
    )
    var alignmentVertical: VerticalAlignment = VerticalAlignment.top

    /// Spacing between elements in the HStack.
    @NativeBlockProp(
        description: "Spacing between elements inside the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "0"
    )
    var spacing: CGFloat = 0

    // MARK: - Padding Properties

    /// Padding at the top of the HStack.
    @NativeBlockProp(
        description: "Padding at the top of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// Padding at the leading edge of the HStack.
    @NativeBlockProp(
        description: "Padding at the leading edge of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// Padding at the bottom of the HStack.
    @NativeBlockProp(
        description: "Padding at the bottom of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// Padding at the trailing edge of the HStack.
    @NativeBlockProp(
        description: "Padding at the trailing edge of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameWidth: String = "notSet"

    @NativeBlockProp(
        description: "Height of the HStack frame.",
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

    @NativeBlockProp(
        description: "Total weight of all items. If 0, child weights are ignored.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0"
    )
    var totalWeight: CGFloat = 0
    // MARK: - Background Properties

    @NativeBlockProp(
        description: "Background color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    @NativeBlockProp(
        description: "Corner radius of the HStack's background.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var cornerRadius: CGFloat = 0

    @NativeBlockProp(
        description: "Border color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    @NativeBlockProp(
        description: "Border width of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Shadow Properties

    /// Shadow color of the HStack.
    /// - `valuePicker`: A color picker for selecting the shadow color.
    @NativeBlockProp(
        description: "Shadow color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var shadowColor: Color = Color.black.opacity(0)

    /// Shadow blur radius of the HStack.
    @NativeBlockProp(
        description: "Shadow blur radius of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowRadius: CGFloat = 0

    /// Horizontal offset of the HStack's shadow.
    @NativeBlockProp(
        description: "Horizontal offset of the HStack's shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowX: CGFloat = 0

    /// Vertical offset of the HStack's shadow.
    @NativeBlockProp(
        description: "Vertical offset of the HStack's shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
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
        GeometryReader { geo in
            HStack(
                alignment: alignmentVertical,
                spacing: spacing
            ) {
                if initialized {
                    if length >= 0 {
                        ForEach(0..<length, id: \.self) { index in
                            content(index, proxy)
                        }
                    } else {
                        content(-1, proxy)
                    }
                } else {
                    Color.clear.onAppear {
                        proxy.geo = geo
                        proxy.totalWeight = totalWeight
                        initialized.toggle()
                    }
                }
            }

        }.blockWidthAndHeightModifier(
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
        .blockOnTapGesture(enable: onClick != nil) {
            onClick?()
        }
    }
}

struct NativeHStack_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeHStack(
            length: 5,
            content: { index, scope in
                if index == 0 {
                    Text("index:\(index)")
                        .weighted(1, proxy: scope)
                        .background(Color.cyan)
                } else if index == 1 {
                    Text("index:\(index)")
                        .weighted(1, proxy: scope)
                        .background(Color.black)
                } else {
                    Text("index:\(index)")
                        .weighted(1, proxy: scope)
                        .background(Color.red)
                }
            },
            alignmentHorizontal: HorizontalAlignment.center,
            alignmentVertical: VerticalAlignment.center,
            spacing: 0,
            paddingTop: 8,
            paddingLeading: 8,
            paddingBottom: 8,
            paddingTrailing: 8,
            frameWidth: "300",
            frameHeight: "200",
            totalWeight: 5,
            backgroundColor: Color.blue,
            cornerRadius: 30,
            borderColor: Color.black,
            borderWidth: 5,
            shadowColor: Color.black,
            shadowRadius: 30,
            shadowX: 7,
            shadowY: 7,
            onClick: {}
        ).padding(10)
            .background(Color.blue)
    }
}
