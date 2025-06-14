import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable text block for Nativeblocks.
///
/// `NativeText` is used to display text with various customizable properties, including font, alignment,
/// padding, and size. It allows precise control over how text appears within layouts.
///
/// ### Features:
/// - Supports font family, weight, size, and color.
/// - Alignment for multi-line and single-line text.
/// - Configurable padding and frame dimensions.
///
/// ### Example:
/// ```swift
/// NativeText(
///     text: "Hello, World!",
///     fontFamily: "system",
///     fontSize: 20,
///     foregroundColor: "#ff0000"
/// )
/// ```
@NativeBlock(
    name: "Native Text",
    keyType: "nativeblocks/text",
    description: "Nativeblocks text block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeText: View {
    var blockProps: BlockProps? = nil
    // MARK: - Data Properties

    /// The text to be displayed.
    @NativeBlockData(description: "The text content to be displayed.")
    var text: String

    // MARK: - Font Properties

    /// The font family of the text.
    @NativeBlockProp(
        description: "The font family for the text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "system"
    )
    var fontFamily: String = "system"

    /// The font weight of the text.
    @NativeBlockProp(
        description: "The weight of the font used for the text.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("regular", "regular"),
            NativeBlockValuePickerOption("thin", "thin"),
            NativeBlockValuePickerOption("medium", "medium"),
            NativeBlockValuePickerOption("semibold", "semibold"),
            NativeBlockValuePickerOption("bold", "bold"),
            NativeBlockValuePickerOption("heavy", "heavy"),
            NativeBlockValuePickerOption("black", "black"),
            NativeBlockValuePickerOption("light", "light"),
            NativeBlockValuePickerOption("ultralight", "ultralight"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "regular"
    )
    var fontWeight: Font.Weight = .regular

    /// The font design of the text.
    @NativeBlockProp(
        description: "Specifies the font design for the text.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("default", "default"),
            NativeBlockValuePickerOption("monospaced", "monospaced"),
            NativeBlockValuePickerOption("rounded", "rounded"),
            NativeBlockValuePickerOption("serif", "serif"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "default"
    )
    var fontDesign: Font.Design = .default

    /// The font size of the text.
    @NativeBlockProp(
        description: "The font size of the text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "16"
    )
    var fontSize: CGFloat = 16

    /// The color of the text.
    @NativeBlockProp(
        description: "The color of the text.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#ff000000"
    )
    var foregroundColor: Color = Color.black

    // MARK: - Alignment Properties

    /// The horizontal alignment of multi-line text.
    @NativeBlockProp(
        description: "Specifies how multi-line text is aligned horizontally.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "leading"
    )
    var multilineTextAlignment: TextAlignment = .leading

    /// The maximum number of lines for the text.
    @NativeBlockProp(
        description: "The maximum number of lines for the text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "1"
    )
    var lineLimit: Int = 1

    // MARK: - Padding Properties

    /// Padding at the top of the Text.
    @NativeBlockProp(
        description: "Padding at the top of the Text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// Padding at the leading edge of the Text.
    @NativeBlockProp(
        description: "Padding at the leading edge of the Text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// Padding at the bottom of the Text.
    @NativeBlockProp(
        description: "Padding at the bottom of the Text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// Padding at the trailing edge of the Text.
    @NativeBlockProp(
        description: "Padding at the trailing edge of the Text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Size Properties

    /// Width of the text frame
    @NativeBlockProp(
        description: "Width of the text frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// Height of the text frame
    @NativeBlockProp(
        description: "Height of the text frame.",
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
        defaultValue: "0"
    )
    var weight: CGFloat = 0
    
    // MARK: - Alignment Properties

    /// The horizontal alignment of the text.
    @NativeBlockProp(
        description: "The horizontal alignment of the text.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "leading"
    )
    var alignmentHorizontal: HorizontalAlignment = .leading

    /// The vertical alignment of the text.
    @NativeBlockProp(
        description: "The vertical alignment of the text.",
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

    var body: some View {
        Text(text)
            .blockFont(family: fontFamily, size: fontSize, weight: fontWeight, design: fontDesign)
            .foregroundColor(foregroundColor)
            .multilineTextAlignment(multilineTextAlignment)
            .lineLimit(lineLimit)
            .blockWidthAndHeightModifier(width, height, alignment: Alignment(horizontal: alignmentHorizontal, vertical: alignmentVertical))
            .weighted(weight, proxy: blockProps?.hierarchy?.last?.scope)
            .padding(.top, paddingTop)
            .padding(.leading, paddingLeading)
            .padding(.bottom, paddingBottom)
            .padding(.trailing, paddingTrailing)
    }
}

struct NativeText_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeText(
            text: "Sample Sample Sample Sample\nSample\nSample\nSample Sample Sample Sample Sample\nSample\n",
            fontFamily: "system",
            fontWeight: .bold,
            fontDesign: .monospaced,
            fontSize: 20,
            foregroundColor: Color.blue,
            multilineTextAlignment: .leading,
            lineLimit: 3,
            paddingTop: 8,
            paddingLeading: 8,
            paddingBottom: 8,
            paddingTrailing: 8,
            width: "fill",
            height: "fill",
        )
    }
}
