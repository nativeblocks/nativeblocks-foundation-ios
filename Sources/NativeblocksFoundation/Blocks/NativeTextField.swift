import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable text field block for Nativeblocks.
///
/// `NativeTextField` allows for user input with various customization options, such as font, alignment,
/// secure text entry, and event handling.
///
/// ### Features:
/// - Handles secure and standard text input.
/// - Configurable keyboard types, autocapitalization, and autocorrection.
/// - Fully customizable font, padding, alignment, and frame.
/// - Triggers events for text changes, editing status, and submission.
///
/// ### Example:
/// ```swift
/// NativeTextField(
///     text: "Enter your text",
///     isEditing: false,
///     onChange: { newText in print("Changed: \(newText)") }
/// )
/// ```
@NativeBlock(
    name: "Native Text field",
    keyType: "nativeblocks/text_field",
    description: "Nativeblocks text field block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeTextField<Content: View>: View {
    var blockProps: BlockProps? = nil

    // MARK: - Data Properties

    /// The current text in the TextField.
    @NativeBlockData(description: "The current text in the TextField.")
    var text: String

    /// The hint text in the TextField.
    @NativeBlockData(description: "The hint text in the TextField.")
    var hint: String

    @State private var localText: String = ""

    // MARK: - Event Properties

    /// Triggered whenever the text in the text field changes, with `text` updated automatically.
    @NativeBlockEvent(
        description: "Triggered whenever the text changes. Updates `text` automatically.",
        dataBinding: ["text"]
    )
    var onChange: (String) -> Void

    // MARK: - Input Properties

    /// Indicates whether the text field hides input for secure entry.
    @NativeBlockProp(
        description: "Hides input for secure entry if set to true.",
        defaultValue: "false"
    )
    var isSecure: Bool = false

    /// An optional leading icon displayed in the TextField.
    @NativeBlockSlot(description: "A view that appears as the leading icon of the TextField.")
    var leadingIcon: ((BlockIndex) -> Content)? = nil

    /// An optional trailing icon displayed in the TextField.
    @NativeBlockSlot(description: "A view that appears as the trailing icon of the TextField.")
    var trailingIcon: ((BlockIndex) -> Content)? = nil

    // MARK: - Font Properties

    /// The font family used in the TextField.
    @NativeBlockProp(
        description: "The font family used in the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "system"
    )
    var fontFamily: String = "system"

    /// The font weight used in the TextField.
    @NativeBlockProp(
        description: "The font weight used in the TextField.",
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
            NativeBlockValuePickerOption("ultraLight", "ultraLight"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "regular"
    )
    var fontWeight: Font.Weight = .regular

    /// The font design used in the TextField.
    @NativeBlockProp(
        description: "The font design used in the TextField.",
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

    /// The font size used in the TextField.
    @NativeBlockProp(
        description: "The font size used in the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "16"
    )
    var fontSize: CGFloat = 16

    /// The text color of the TextField.
    @NativeBlockProp(
        description: "The text color of the TextField.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#ff000000"
    )
    var foregroundColor: Color = .black

    /// The background color of the TextField.
    @NativeBlockProp(
        description: "The background color of the TextField.",
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    // MARK: - Padding Properties

    /// Padding at the top of the TextField.
    @NativeBlockProp(
        description: "Padding at the top of the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// Padding at the leading edge of the TextField.
    @NativeBlockProp(
        description: "Padding at the leading edge of the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// Padding at the bottom of the TextField.
    @NativeBlockProp(
        description: "Padding at the bottom of the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// Padding at the trailing edge of the TextField.
    @NativeBlockProp(
        description: "Padding at the trailing edge of the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Border Properties

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

    /// Border color of the TextField.
    @NativeBlockProp(
        description: "Border color of the TextField.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// Border width of the TextField.
    @NativeBlockProp(
        description: "Border width of the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    // MARK: - Size Properties

    /// Width of the TextField frame
    @NativeBlockProp(
        description: "Width of the TextField frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// Height of the TextField frame
    @NativeBlockProp(
        description: "Height of the TextField frame.",
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

    /// The multiline text alignment of the TextField.
    @NativeBlockProp(
        description: "The alignment for multiline text within the TextField.",
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

    /// The maximum number of lines allowed in the TextField.
    @NativeBlockProp(
        description: "The maximum number of lines for the TextField.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "1"
    )
    var lineLimit: Int = 1

    /// Specifies the keyboard type for the TextField.
    @NativeBlockProp(
        description: "Specifies the keyboard type for the TextField.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("default", "default"),
            NativeBlockValuePickerOption("asciiCapable", "asciiCapable"),
            NativeBlockValuePickerOption("numbersAndPunctuation", "numbersAndPunctuation"),
            NativeBlockValuePickerOption("URL", "url"),
            NativeBlockValuePickerOption("numberPad", "numberPad"),
            NativeBlockValuePickerOption("phonePad", "phonePad"),
            NativeBlockValuePickerOption("namePhonePad", "namePhonePad"),
            NativeBlockValuePickerOption("emailAddress", "emailAddress"),
            NativeBlockValuePickerOption("decimalPad", "decimalPad"),
            NativeBlockValuePickerOption("webSearch", "webSearch"),
            NativeBlockValuePickerOption("asciiCapableNumberPad", "asciiCapableNumberPad"),
            NativeBlockValuePickerOption("alphabet", "alphabet"),
        ],
        defaultValue: "default"
    )
    var keyboardType: String = "default"

    init(
        blockProps: BlockProps?,
        text: String,
        hint: String,
        onChange: @escaping (String) -> Void,
        isSecure: Bool,
        leadingIcon: ((BlockIndex) -> Content)?,
        trailingIcon: ((BlockIndex) -> Content)?,
        fontFamily: String,
        fontWeight: Font.Weight,
        fontDesign: Font.Design,
        fontSize: CGFloat,
        foregroundColor: Color,
        backgroundColor: Color,
        paddingTop: CGFloat,
        paddingLeading: CGFloat,
        paddingBottom: CGFloat,
        paddingTrailing: CGFloat,
        radiusTopStart: CGFloat,
        radiusTopEnd: CGFloat,
        radiusBottomStart: CGFloat,
        radiusBottomEnd: CGFloat,
        borderColor: Color,
        borderWidth: CGFloat,
        width: String,
        height: String,
        weight: CGFloat,
        multilineTextAlignment: TextAlignment,
        lineLimit: Int,
        keyboardType: String
    ) {
        self.blockProps = blockProps
        self.text = text
        self.hint = hint
        self.onChange = onChange
        self.isSecure = isSecure
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.fontFamily = fontFamily
        self.fontWeight = fontWeight
        self.fontDesign = fontDesign
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.paddingTop = paddingTop
        self.paddingLeading = paddingLeading
        self.paddingBottom = paddingBottom
        self.paddingTrailing = paddingTrailing
        self.radiusTopStart = radiusTopStart
        self.radiusTopEnd = radiusTopEnd
        self.radiusBottomStart = radiusBottomStart
        self.radiusBottomEnd = radiusBottomEnd
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.width = width
        self.height = height
        self.weight = weight
        self.multilineTextAlignment = multilineTextAlignment
        self.lineLimit = lineLimit
        self.keyboardType = keyboardType
    }

    var body: some View {
        HStack(alignment: VerticalAlignment.center) {
            leadingIcon?(-1)
            if isSecure {
                configuredField(
                    SecureField(hint, text: $localText)
                        .onChange(of: text) { newValue in
                            self.localText = newValue
                            onChange(newValue)
                        }
                )
            } else {
                configuredField(
                    TextField(hint, text: $localText)
                        .onChange(of: text) { newValue in
                            self.localText = newValue
                            onChange(newValue)
                        }
                )
            }
            trailingIcon?(-1)
        }
        .blockWidthAndHeightModifier(width, height)
        .weighted(weight, proxy: blockProps?.hierarchy.last?.scope)
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .onAppear {
            self.localText = self.text
        }
    }

    @ViewBuilder
    private func configuredField<T: View>(_ field: T) -> some View {
        field
            .blockKeyboardType(keyboardType)
            .blockFont(family: fontFamily, size: fontSize, weight: fontWeight, design: fontDesign)
            .foregroundColor(foregroundColor)
            .blockWidthAndHeightModifier("fill", "auto")
            .background(backgroundColor)
            .multilineTextAlignment(multilineTextAlignment)
            .lineLimit(lineLimit)
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

struct NativeTextFieldTest: View {
    @State var text = "test"

    var body: some View {
        VStack {
            NativeTextField(
                blockProps: nil,
                text: text,
                hint: "",
                onChange: { newText in
                    print("Text changed: \(newText)")
                    self.text = newText
                },
                isSecure: false,
                leadingIcon: { _ in
                    AnyView(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(Color.primary))
                },
                trailingIcon: { _ in
                    AnyView(
                        Image(systemName: "a")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color.white))
                },
                fontFamily: "system",
                fontWeight: .regular,
                fontDesign: .default,
                fontSize: 16,
                foregroundColor: Color.black,
                backgroundColor: Color.white,
                paddingTop: 10,
                paddingLeading: 16,
                paddingBottom: 10,
                paddingTrailing: 10,
                radiusTopStart: 0,
                radiusTopEnd: 0,
                radiusBottomStart: 0,
                radiusBottomEnd: 0,
                borderColor: Color.black.opacity(0),
                borderWidth: 0,
                width: "fill",
                height: "auto",
                weight: 0,
                multilineTextAlignment: .leading,
                lineLimit: 1,
                keyboardType: "default"
            )
        }
    }
}

struct NativeTextField_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        NativeTextFieldTest()
            .previewLayout(.sizeThatFits)
    }
}
