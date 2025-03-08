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
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable"),
        defaultValue: "visible"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Scrollable"),
        defaultValue: "vertical"
    )
    var scrollDirection: Axis.Set = .vertical

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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "leading"
    )
    var alignmentHorizontal: HorizontalAlignment = .leading

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

    /// The top padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The top padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading (left) padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The leading padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The bottom padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// The trailing (right) padding of the content inside the ScrollView.
    @NativeBlockProp(
        description: "The trailing padding of the content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameHeight: String = "notSet"

    // MARK: - Background Properties

    /// The background color of the ScrollView.
    @NativeBlockProp(
        description: "The background color of the ScrollView.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    /// The corner radius of the ScrollView.
    @NativeBlockProp(
        description: "The corner radius of the ScrollView.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var cornerRadius: CGFloat = 0

    /// The border color of the ScrollView.
    @NativeBlockProp(
        description: "The border color of the ScrollView.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border width of the ScrollView.
    @NativeBlockProp(
        description: "The border width of the ScrollView.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Shadow Properties

    /// The shadow color of the ScrollView.
    @NativeBlockProp(
        description: "The shadow color of the ScrollView.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var shadowColor: Color = Color.black.opacity(0)

    /// The blur radius of the ScrollView's shadow.
    @NativeBlockProp(
        description: "The blur radius of the ScrollView shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal offset of the ScrollView's shadow.
    @NativeBlockProp(
        description: "The horizontal offset of the ScrollView shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowX: CGFloat = 0

    /// The vertical offset of the ScrollView's shadow.
    @NativeBlockProp(
        description: "The vertical offset of the ScrollView shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowY: CGFloat = 0

    var body: some View {
        ScrollView(scrollDirection) {
            content(-1)
        }
        .blockScrollIndicators(scrollIndicators)
        .blockWidthAndHeightModifier(
            frameWidth,
            frameHeight,
            alignment: Alignment(
                horizontal: alignmentHorizontal,
                vertical: alignmentVertical
            )
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
                alignmentHorizontal: .center,
                alignmentVertical: .center,
                spacing: 0,
                paddingTop: 0,
                paddingLeading: 0,
                paddingBottom: 0,
                paddingTrailing: 0,
                frameWidth: "300",
                frameHeight: "infinity",
                backgroundColor: Color.blue,
                cornerRadius: 30,
                borderColor: Color.white,
                borderWidth: 5,
                shadowColor: Color.black,
                shadowRadius: 30,
                shadowX: 7,
                shadowY: 7
            )
        }
        .padding(10)
        .background(Color.blue)
    }
}
