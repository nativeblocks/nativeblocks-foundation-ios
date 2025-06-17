import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable HStack block for Nativeblocks.
///
/// `NativeHStack` is a flexible horizontal stack layout that integrates with the Nativeblocks ecosystem.
/// It supports features like customizable alignment, spacing, padding, colors, and more.
///
/// ### Features:
/// - Dynamic content defined using slots.
/// - Configurable alignment, padding, and size.
/// - Background, border and styling options.
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
    keyType: "nativeblocks/hstack",
    description: "Nativeblocks HStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeHStack<Content: View>: View {
    private let proxy = WeightedProxy(kind: .horizontal)
    @State private var initialized = false
    var blockProps: BlockProps? = nil
    
    /// Length of list
    @NativeBlockData(
        description: "Length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Properties

    /// The content displayed inside the HStack.
    @NativeBlockSlot(description: "The content displayed inside the HStack.")
    var content: (BlockIndex, Any) -> Content

    // MARK: - Alignment Properties

    /// Horizontal alignment of the HStack's content.
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

    /// Vertical alignment of the HStack's content.
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

    /// Spacing between elements inside the HStack.
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

    /// Width of the HStack frame
    @NativeBlockProp(
        description: "Width of the HStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// Height of the HStack frame
    @NativeBlockProp(
        description: "Height of the HStack frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"
    
    /// Weight of the layout in HStack or VStack. Default is 0 means not set
    @NativeBlockProp(
        description: "Weight of the layout in HStack or VStack. Default is 0 means not set.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0.0"
    )
    var weight: CGFloat = 0.0
    
    // MARK: - Background Properties

    /// Background color of the HStack.
    @NativeBlockProp(
        description: "Background color of the HStack.",
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
    
    /// Border color of the HStack.
    @NativeBlockProp(
        description: "Border color of the HStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// Border width of the HStack.
    @NativeBlockProp(
        description: "Border width of the HStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Event Handlers

    /// Action triggered when the HStack is tapped.
    @NativeBlockEvent(
        description: "Action triggered when the HStack is tapped."
    )
    var onClick: (() -> Void)?

    // MARK: - Body

    var body: some View {
        GeometryReader { geo in
            HStack(alignment: alignmentVertical, spacing: spacing) {
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
                        initialized.toggle()
                    }
                }
            }
        }
        .blockWidthAndHeightModifier(width, height)
        .weighted(weight, proxy: blockProps?.hierarchy?.last?.scope)
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
