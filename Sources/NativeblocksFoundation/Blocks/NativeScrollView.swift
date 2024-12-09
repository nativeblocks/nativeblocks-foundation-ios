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
    keyType: "NATIVE_SCROLLVIEW",
    description: "Nativeblocks ScrollView block",
    version: 1
)
struct NativeScrollView<Content: View>: View {
    // MARK: - Slot Properties

    /// The content displayed inside the ScrollView.
    @NativeBlockSlot(description: "The scrollable content of the ScrollView.")
    var content: (BlockIndex) -> Content

    // MARK: - Scrollable Properties

    /// Controls the visibility of scroll indicators.
    @NativeBlockProp(
        description: "Determines the visibility of the scroll indicators.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("hidden", "hidden"),
            NativeBlockValuePickerOption("never", "never"),
            NativeBlockValuePickerOption("visible", "visible"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable")
    )
    var scrollIndicators: String = "visible"

    /// Specifies the scrolling direction of the ScrollView.
    @NativeBlockProp(
        description: "Sets the direction of scrolling (vertical, horizontal, or both).",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("vertical", "vertical"),
            NativeBlockValuePickerOption("horizontal", "horizontal"),
            NativeBlockValuePickerOption("both", "horizontal"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable")
    )
    var scrollDirection: String = "vertical"

    // MARK: - Alignment Properties

    /// The horizontal alignment of the content inside the ScrollView.
    @NativeBlockProp(
        description: "Specifies the horizontal alignment of the content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "leading"

    /// The vertical alignment of the content inside the ScrollView.
    @NativeBlockProp(
        description: "Specifies the vertical alignment of the content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
            NativeBlockValuePickerOption("lasttextbaseline", "lastTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentVertical: String = "top"

    /// The spacing between elements inside the ScrollView.
    @NativeBlockProp(
        description: "The spacing between elements inside the ScrollView.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var spacing: CGFloat = 0

    // MARK: - Direction Properties

    /// The layout direction of the content (LTR or RTL).
    @NativeBlockProp(
        description: "Sets the layout direction of the content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "RTL"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction")
    )
    var direction: String = "LTR"

    // MARK: - Padding Properties

    /// The top padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The top padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTop: CGFloat = 0

    /// The leading (left) padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The leading padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The bottom padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingBottom: CGFloat = 0

    /// The trailing (right) padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The trailing padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Frame Properties

    /// The width of the ScrollView's frame.
    @NativeBlockProp(
        description: "The width of the ScrollView frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameWidth: String = "notSet"

    /// The height of the ScrollView's frame.
    @NativeBlockProp(
        description: "The height of the ScrollView frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameHeight: String = "notSet"

    // MARK: - Background Properties

    /// The background color of the ScrollView.
    @NativeBlockProp(
        description: "The background color of the ScrollView.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#00000000"

    /// The corner radius of the ScrollView.
    @NativeBlockProp(
        description: "The corner radius of the ScrollView.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var cornerRadius: CGFloat = 0

    /// The border color of the ScrollView.
    @NativeBlockProp(
        description: "The border color of the ScrollView.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"

    /// The border width of the ScrollView.
    @NativeBlockProp(
        description: "The border width of the ScrollView.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderWidth: CGFloat = 0

    // MARK: - Shadow Properties

    /// The shadow color of the ScrollView.
    @NativeBlockProp(
        description: "The shadow color of the ScrollView.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowColor: String = "#00000000"

    /// The blur radius of the ScrollView's shadow.
    @NativeBlockProp(
        description: "The blur radius of the ScrollView shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal offset of the ScrollView's shadow.
    @NativeBlockProp(
        description: "The horizontal offset of the ScrollView shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowX: CGFloat = 0

    /// The vertical offset of the ScrollView's shadow.
    @NativeBlockProp(
        description: "The vertical offset of the ScrollView shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowY: CGFloat = 0

    // MARK: - Event Handlers

    /// The action triggered when the ScrollView is tapped.
    @NativeBlockEvent(description: "The action triggered when the ScrollView is tapped.")
    var onClick: () -> Void

    var body: some View {
        ScrollView(mapBlockScrollable(scrollDirection)) {
            content(-1)
        }
        .blockScrollIndicators(scrollIndicators)
        .blockWidthAndHeightModifier(
            frameWidth,
            frameHeight,
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
            onClick()
        }
    }
}

#Preview("NativeVStack") {
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
            scrollDirection: "both",
            alignmentHorizontal: "center",
            alignmentVertical: "center",
            spacing: 0,
            direction: "RTL",
            paddingTop: 0,
            paddingLeading: 0,
            paddingBottom: 0,
            paddingTrailing: 0,
            frameWidth: "300",
            frameHeight: "infinity",
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
