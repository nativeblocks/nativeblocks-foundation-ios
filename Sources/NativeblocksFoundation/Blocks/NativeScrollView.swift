import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable ScrollView block for Nativeblocks.
///
/// `NativeScrollView` provides a flexible scrollable container for content,
/// with customizable alignment, padding, frame, and appearance settings.
///
/// ### Features:
/// - Supports vertical, horizontal, or bidirectional scrolling.
/// - Customizable padding, frame, and background.
/// - Configurable alignment and scroll indicators visibility.
/// - Shadow and border support for enhanced styling.
///
/// ### Example:
/// ```swift
/// NativeScrollView(
///     content: { index in HStack { Text("Scrollable Content") } }
/// )
/// ```
@NativeBlock(
    name: "Native ScrollView",
    keyType: "nativeblocks/scrollview",
    description: "Nativeblocks ScrollView block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeScrollView<Content: View>: View {
    var blockProps: BlockProps? = nil
    // MARK: - Slot Properties

    /// The scrollable content of the ScrollView.
    @NativeBlockSlot(description: "The scrollable content of the ScrollView.")
    var content: (BlockIndex) -> Content

    // MARK: - Scrollable Properties

    /// Controls the visibility of scroll indicators.
    @NativeBlockProp(
        description: "Controls the visibility of scroll indicators.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("hidden", "hidden"),
            NativeBlockValuePickerOption("never", "never"),
            NativeBlockValuePickerOption("visible", "visible"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable"),
        defaultValue: "visible"
    )
    var scrollIndicators: String = "visible"

    /// Sets the direction of scrolling (vertical, horizontal, or both).
    @NativeBlockProp(
        description: "Sets the direction of scrolling (vertical, horizontal, or both).",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("vertical", "vertical"),
            NativeBlockValuePickerOption("horizontal", "horizontal"),
            NativeBlockValuePickerOption("both", "horizontal"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable"),
        defaultValue: "vertical"
    )
    var scrollDirection: Axis.Set = .vertical

    // MARK: - Alignment Properties

    /// The horizontal alignment of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The horizontal alignment of the content inside the ScrollView.",
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

    /// The vertical alignment of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The vertical alignment of the content inside the ScrollView.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
            NativeBlockValuePickerOption("lasttextbaseline", "lastTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "top"
    )
    var alignmentVertical: VerticalAlignment = .top

    /// The spacing between elements inside the ScrollView.
    @NativeBlockProp(
        description: "The spacing between elements inside the ScrollView.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "0"
    )
    var spacing: CGFloat = 0

    // MARK: - Padding Properties

    /// The top padding of the content.
    @NativeBlockProp(
        description: "The top padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading padding of the content.
    @NativeBlockProp(
        description: "The leading padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding of the content.
    @NativeBlockProp(
        description: "The bottom padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// The trailing padding of the content.
    @NativeBlockProp(
        description: "The trailing padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Frame Properties

    /// The width of the ScrollView frame.
    @NativeBlockProp(
        description: "The width of the ScrollView frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// The height of the ScrollView frame.
    @NativeBlockProp(
        description: "The height of the ScrollView frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"
    
    /// Weight of the layout in HStack or VStack. Default is 0 means not set.
    @NativeBlockProp(
        description: "Weight of the layout in HStack or VStack. Default is 0 means not set.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0.0"
    )
    var weight: CGFloat = 0.0
    // MARK: - Background Properties
    
    /// The background color of the ScrollView.
    @NativeBlockProp(
        description: "The background color of the ScrollView.",
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

    var body: some View {
        ScrollView(scrollDirection) {
            content(-1)
        }
        .blockScrollIndicators(scrollIndicators)
        .blockWidthAndHeightModifier(width, height, alignment: Alignment(horizontal: alignmentHorizontal, vertical: alignmentVertical))
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
    }
}

struct NativeScrollView_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        HStack {
            NativeScrollView(
                content: { _ in
                    HStack {

                        Text("Top Left Aligned")
                            .frame(
                                minWidth: 100,
                                maxWidth: 100,
                                minHeight: 100,
                                maxHeight: 100,
                                alignment: Alignment.center
                            )
                            .background(Color.brown)

                        Text("Top Left Aligned")
                            .frame(
                                minWidth: 100,
                                maxWidth: 100,
                                minHeight: 100,
                                maxHeight: 100,
                                alignment: Alignment.center
                            )
                            .background(Color.red)
                    }
                },
                scrollIndicators: "visible",
                scrollDirection: .vertical,
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
            )
        }
        .padding(10)
        .background(Color.blue)
    }
}
