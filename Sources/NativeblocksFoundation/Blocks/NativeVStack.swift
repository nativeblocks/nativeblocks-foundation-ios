import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable vertical stack (VStack) block for Nativeblocks.
///
/// `NativeVStack` allows you to stack child views vertically with alignment, spacing, padding,
/// and styling options. It also supports click events and customizable layout.
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
///     alignmentVertical: "top",
///     spacing: 10,
///     backgroundColor: "#ffffff",
///     onClick: { print("VStack clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native VStack",
    keyType: "nativeblocks/VSTACK",
    description: "Nativeblocks VStack block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeVStack<Content: View>: View {
    private let proxy = WeightedProxy(kind: .vertical)
    @State private var initialized = false
    var blockProps: BlockProps? = nil
    @NativeBlockData(
        description: "length of list",
        defaultValue: "-1"
    )
    var length: Int = -1
    // MARK: - Slot Properties

    /// The content of the VStack, provided as a slot.
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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "top"
    )
    var alignmentVertical: VerticalAlignment = .top

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

    /// The leading (left) padding inside the VStack.
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

    /// The trailing (right) padding inside the VStack.
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
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
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
    // MARK: - Background and Styling Properties

    /// The background color of the VStack.
    @NativeBlockProp(
        description: "The background color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    /// The corner radius of the VStack.
    @NativeBlockProp(
        description: "The corner radius of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var cornerRadius: CGFloat = 0

    /// The border color of the VStack.
    @NativeBlockProp(
        description: "The border color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the VStack.
    @NativeBlockProp(
        description: "The border width of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    /// The shadow color of the VStack.
    @NativeBlockProp(
        description: "The shadow color of the VStack.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var shadowColor: Color = Color.black.opacity(0)

    /// The shadow radius of the VStack.
    @NativeBlockProp(
        description: "The shadow radius of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal shadow offset of the VStack.
    @NativeBlockProp(
        description: "The horizontal shadow offset of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowX: CGFloat = 0

    /// The vertical shadow offset of the VStack.
    @NativeBlockProp(
        description: "The vertical shadow offset of the VStack.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Properties

    /// Triggered when the VStack is clicked.
    @NativeBlockEvent(description: "Triggered when the VStack is clicked.")
    var onClick: (() -> Void)?

    var body: some View {
        GeometryReader { geo in
            VStack(
                alignment: alignmentHorizontal,
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
        }
        .blockWidthAndHeightModifier(
            frameWidth,
            frameHeight,
            alignment: Alignment(
                horizontal: alignmentHorizontal,
                vertical: alignmentVertical)
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
                            "infinity",
                            "notSet",
                            alignment: Alignment.bottom
                        )
                        .weighted(1, proxy: scope)
                        .background(Color.cyan)
                } else if index == 1 {
                    Text("index:\(index)")
                        .blockWidthAndHeightModifier(
                            "infinity",
                            "notSet",
                            alignment: Alignment.bottom
                        )
                        .weighted(1, proxy: scope)
                        .background(Color.black)
                } else {
                    Text("index:\(index)")
                        .blockWidthAndHeightModifier(
                            "infinity",
                            "notSet",
                            alignment: Alignment.bottom
                        )
                        .weighted(0, proxy: scope)
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
            totalWeight: 3,
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
