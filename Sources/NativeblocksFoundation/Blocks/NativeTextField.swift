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
///     onCommit: { print("Commit!") },
///     onEditingChanged: { isEditing in print("Editing: \(isEditing)") },
///     onChange: { newText in print("Changed: \(newText)") }
/// )
/// ```
@NativeBlock(
    name: "Native Text field",
    keyType: "nativeblocks/TEXT_FIELD",
    description: "Nativeblocks text field block",
    version: 1
)
struct NativeTextField: View {
    var blockProps: BlockProps? = nil
    // MARK: - Data Properties

    /// The current text in the text field.
    @NativeBlockData(description: "The current text in the text field.")
    var text: String

    /// The local state of the text field for internal binding.
    @State private var localText: String = ""

    /// Indicates whether the text field is currently being edited.
    @NativeBlockData(description: "Indicates whether the text field is currently being edited.")
    var isEditing: Bool

    // MARK: - Event Properties

    /// Triggered when the text field's editing is committed.
    @NativeBlockEvent(description: "Triggered when the text field's editing is committed.")
    var onCommit: () -> Void

    /// Triggered when the editing state changes, with `isEditing` updated automatically.
    @NativeBlockEvent(
        description: "Triggered when the editing state changes. Updates `isEditing` automatically.",
        dataBinding: ["isEditing"]
    )
    var onEditingChanged: (Bool) -> Void

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

    /// Disables autocorrection if set to true.
    @NativeBlockProp(
        description: "Disables autocorrection if set to true.",
        defaultValue: "false"
    )
    var disableAutocorrection: Bool = false

    // MARK: - Font Properties

    /// The font family used in the text field.
    @NativeBlockProp(
        description: "The font family used in the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "system"
    )
    var fontFamily: String = "system"

    /// The font weight used in the text field.
    @NativeBlockProp(
        description: "The font weight used in the text field.",
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

    /// The font design used in the text field.
    @NativeBlockProp(
        description: "The font design used in the text field.",
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

    /// The font size used in the text field.
    @NativeBlockProp(
        description: "The font size used in the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "16"
    )
    var fontSize: CGFloat = 16

    /// The text color of the text field.
    @NativeBlockProp(
        description: "The text color of the text field.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#ff000000"
    )
    var foregroundColor: Color = .black

    /// The background color of the text field.
    @NativeBlockProp(
        description: "The background color of the text field.",
        defaultValue: "#00000000"
    )
    var backgroundColor: Color = Color.black.opacity(0)

    // MARK: - Layout and Appearance Properties

    /// The top padding of the text field.
    @NativeBlockProp(
        description: "The top padding inside the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// The leading (left) padding of the text field.
    @NativeBlockProp(
        description: "The leading padding inside the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// The bottom padding of the text field.
    @NativeBlockProp(
        description: "The bottom padding inside the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// The trailing (right) padding of the text field.
    @NativeBlockProp(
        description: "The trailing padding inside the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    /// The width of the text field's frame.
    @NativeBlockProp(
        description: "The width of the text field's frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameWidth: String = "notSet"

    /// The height of the text field's frame.
    @NativeBlockProp(
        description: "The height of the text field's frame.",
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
    /// The corner radius of the text field.
    @NativeBlockProp(
        description: "The corner radius of the text field.",
        defaultValue: "8.0"
    )
    var cornerRadius: CGFloat = 8.0

    // MARK: - Alignment Properties

    /// The horizontal alignment of the text field.
    @NativeBlockProp(
        description: "The horizontal alignment of the text field.",
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

    /// The vertical alignment of the text field.
    @NativeBlockProp(
        description: "The vertical alignment of the text field.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "top"
    )
    var alignmentVertical: VerticalAlignment = .top

    /// The multiline text alignment of the text field.
    @NativeBlockProp(
        description: "The alignment for multiline text within the text field.",
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

    /// The maximum number of lines allowed in the text field.
    @NativeBlockProp(
        description: "The maximum number of lines for the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "9999"
    )
    var lineLimit: Int = 9999

    /// The spacing between lines of text.
    @NativeBlockProp(
        description: "The spacing between lines of text in the text field.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "0"
    )
    var lineSpacing: CGFloat = 0

    /// Specifies the keyboard type for the text field.
    @NativeBlockProp(
        description: "Specifies the keyboard type for the text field.",
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
            NativeBlockValuePickerOption("twitter", "twitter"),
            NativeBlockValuePickerOption("webSearch", "webSearch"),
            NativeBlockValuePickerOption("asciiCapableNumberPad", "asciiCapableNumberPad"),
            NativeBlockValuePickerOption("alphabet", "alphabet"),
        ],
        defaultValue: "default"
    )
    var keyboardType: String = "default"
    /// Specifies the autocapitalization type for the text field.
    @NativeBlockProp(
        description: "Specifies the autocapitalization type for the text field.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("none", "none"),
            NativeBlockValuePickerOption("allCharacters", "allCharacters"),
            NativeBlockValuePickerOption("sentences", "sentences"),
            NativeBlockValuePickerOption("words", "words"),
        ],
        defaultValue: "none"
    )
    var autocapitalization: String = "none"

    init(
        blockProps: BlockProps?,
        text: String, isEditing: Bool, onCommit: @escaping () -> Void, onEditingChanged: @escaping (Bool) -> Void,
        onChange: @escaping (String) -> Void, isSecure: Bool, disableAutocorrection: Bool, fontFamily: String, fontWeight: Font.Weight,
        fontDesign: Font.Design, fontSize: CGFloat, foregroundColor: Color, backgroundColor: Color,
        paddingTop: CGFloat, paddingLeading: CGFloat, paddingBottom: CGFloat, paddingTrailing: CGFloat, frameWidth: String,
        frameHeight: String, frameWeight: CGFloat, cornerRadius: CGFloat, alignmentHorizontal: HorizontalAlignment,
        alignmentVertical: VerticalAlignment,
        multilineTextAlignment: TextAlignment, lineLimit: Int, lineSpacing: CGFloat, keyboardType: String,
        autocapitalization: String
    ) {
        self.blockProps = blockProps
        self.text = text
        //        self.localText = text
        self.isEditing = isEditing
        self.onCommit = onCommit
        self.onEditingChanged = onEditingChanged
        self.onChange = onChange
        self.isSecure = isSecure
        self.disableAutocorrection = disableAutocorrection
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
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.frameWeight = frameWeight
        self.cornerRadius = cornerRadius
        self.alignmentHorizontal = alignmentHorizontal
        self.alignmentVertical = alignmentVertical
        self.multilineTextAlignment = multilineTextAlignment
        self.lineLimit = lineLimit
        self.lineSpacing = lineSpacing
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
    }

    var body: some View {
        ZStack {
            if isSecure {
                SecureField(
                    "", text: $localText,
                    onCommit: {
                        onCommit()
                    }
                )
                .textFieldStyle(PlainTextFieldStyle())
                .blockKeyboardType(keyboardType)
                .blockAutocapitalization(autocapitalization)
                .blockFont(
                    family: fontFamily,
                    size: fontSize,
                    weight: fontWeight,
                    design: fontDesign
                )
                .foregroundColor(foregroundColor)
                .blockWidthAndHeightModifier(
                    frameWidth,
                    frameHeight,
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
                .multilineTextAlignment(multilineTextAlignment)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)

                TextField("", text: $localText) { _ in
                }
                .opacity(0.0)
                .blockKeyboardType(keyboardType)
                .blockAutocapitalization(autocapitalization)
                .disableAutocorrection(disableAutocorrection)
                .multilineTextAlignment(multilineTextAlignment)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)
                .onChange(of: localText) { newValue in
                    onChange(newValue)
                }

            } else {
                TextField(
                    "", text: $localText,
                    onEditingChanged: { isEditing in
                        onEditingChanged(isEditing)
                    },
                    onCommit: {
                        onCommit()
                    }
                )
                .textFieldStyle(PlainTextFieldStyle())
                .blockKeyboardType(keyboardType)
                .blockAutocapitalization(autocapitalization)
                .disableAutocorrection(disableAutocorrection)
                .blockFont(
                    family: fontFamily,
                    size: fontSize,
                    weight: fontWeight,
                    design: fontDesign
                )
                .foregroundColor(foregroundColor)
                .blockWidthAndHeightModifier(
                    frameWidth,
                    frameHeight,
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
                .multilineTextAlignment(multilineTextAlignment)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)
                .onChange(of: localText) { newValue in
                    onChange(newValue)
                }
            }
        }
    }
}

struct NativeTextFieldTest: View {
    @State var text = "test"

    var body: some View {
        VStack {
            NativeText(
                text: text,
                fontFamily: "system",
                fontWeight: .bold,
                fontDesign: .monospaced,
                fontSize: 20,
                foregroundColor: Color.blue,
                multilineTextAlignment: .leading,
                lineLimit: 3,
                lineSpacing: 9,
                paddingTop: 8,
                paddingLeading: 8,
                paddingBottom: 8,
                paddingTrailing: 8,
                frameWidth: "infinity",
                frameHeight: "notSet"
            )
            NativeTextField(
                blockProps: nil,
                text: text,
                isEditing: false,
                onCommit: {
                    print("Commit triggered")
                },
                onEditingChanged: { isEditing in
                    print("Editing changed: \(isEditing)")
                },
                onChange: { newText in
                    print("Text changed: \(newText)")
                    self.text = newText
                },
                isSecure: false,
                disableAutocorrection: false,
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
                frameWidth: "infinity",
                frameHeight: "notSet",
                frameWeight: 0,
                cornerRadius: 8.0,
                alignmentHorizontal: .leading,
                alignmentVertical: .top,
                multilineTextAlignment: .leading,
                lineLimit: 1,
                lineSpacing: 0,
                keyboardType: "default",
                autocapitalization: "none"
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
