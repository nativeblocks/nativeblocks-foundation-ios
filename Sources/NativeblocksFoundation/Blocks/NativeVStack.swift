import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable vertical stack (VStack) block for Nativeblocks.
///
/// `NativeVStack` is a flexible vertical stack layout that integrates with the Nativeblocks ecosystem.
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
/// NativeVStack(
///     content: { _ in
///          Text("Top Left Aligned")
///            .padding()
///     },
///     alignmentHorizontal: "center",
///     spacing: 10,
///     backgroundColor: "#ffffff",
///     onClick: { print("VStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native VStack",
    keyType: "nativeblocks/vstack",
    description: "Nativeblocks VStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeVStack<Content: View>: View {
    private let proxy = WeightedProxy(kind: .vertical)
    @State private var initialized = false
    var blockProps: BlockProps? = nil
    
    /// Length of list
    @NativeBlockData(
        description: "Length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Slot Properties

    /// The content to display inside the VStack.
    @NativeBlockSlot(description: "The content to display inside the VStack.")
    var content: (BlockIndex, Any) -> Content

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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "leading"
    )
    var alignmentHorizontal: HorizontalAlignment = .leading

    // MARK: - Layout Properties

    /// The spacing between child views in the VStack.
    @NativeBlockProp(
        description: "The spacing between child views in the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "0"
    )
    var spacing: CGFloat = 0

    // MARK: - Padding Properties

    /// The top padding inside the VStack.
    @NativeBlockProp(
        description: "The top padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading padding inside the VStack..
    @NativeBlockProp(
        description: "The leading padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding inside the VStack.
    @NativeBlockProp(
        description: "The bottom padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// The trailing padding inside the VStack.
    @NativeBlockProp(
        description: "The trailing padding inside the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Frame Properties

    /// The width of the VStack's frame.
    @NativeBlockProp(
        description: "The width of the VStack's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// The height of the VStack's frame.
    @NativeBlockProp(
        description: "The height of the VStack's frame.",
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
    
    // MARK: - Background and Styling Properties

    /// The background color of the VStack.
    @NativeBlockProp(
        description: "The background color of the VStack.",
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
    
    /// The border color of the VStack.
    @NativeBlockProp(
        description: "The border color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the VStack.
    @NativeBlockProp(
        description: "The border width of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Event Properties

    /// Action triggered when the VStack is tapped.
    @NativeBlockEvent(description: "Action triggered when the VStack is tapped.")
    var onClick: (() -> Void)?
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: alignmentHorizontal, spacing: spacing) {
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

struct NativeVStack_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeVStack(
            length: 3,
            content: { index, scope in
                if index == 0 {
                    Text("index:\(index)")
                        .blockWidthAndHeightModifier(
                            "fill",
                            "auto",
                        )
                        .weighted(1, proxy: scope)
                        .background(Color.cyan)
                } else if index == 1 {
                    Text("index:\(index)")
                        .blockWidthAndHeightModifier(
                            "fill",
                            "auto",
                        )
                        .weighted(1, proxy: scope)
                        .background(Color.black)
                } else {
                    Text("index:\(index)")
                        .blockWidthAndHeightModifier(
                            "fill",
                            "auto",
                        )
                        .weighted(0, proxy: scope)
                        .background(Color.red)
                }
            },
            alignmentHorizontal: HorizontalAlignment.center,
            spacing: 0,
            paddingTop: 8,
            paddingLeading: 8,
            paddingBottom: 8,
            paddingTrailing: 8,
            width: "300",
            height: "200",
            weight: 0,
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
