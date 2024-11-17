import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Text field",
    keyType: "NATIVE_TEXT_FIELD",
    description: "Nativeblocks text field block",
    version: 2
)
struct NativeTextField: View {
    @NativeBlockData
    var text: String
    @State private var localText: String
    @NativeBlockData
    var isEditing: Bool
    @NativeBlockEvent
    var onCommit: () -> Void
    @NativeBlockEvent(
        dataBinding: ["isEditing"]
    )
    var onEditingChanged: (Bool) -> Void
    @NativeBlockEvent(
        dataBinding: ["text"]
    )
    var onChange: (String) -> Void
    @NativeBlockProp
    var isSecure: Bool = false
    @NativeBlockProp(
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
        ]
    )
    var keyboardType: String = "default"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("none", "none"),
            NativeBlockValuePickerOption("allCharacters", "allCharacters"),
            NativeBlockValuePickerOption("sentences", "sentences"),
            NativeBlockValuePickerOption("words", "words"),
        ]
    )
    var autocapitalization: String = "none"
    @NativeBlockProp
    var disableAutocorrection: Bool = false
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var fontFamily: String = "system"
    @NativeBlockProp(
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
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var fontWeight: String = "regular"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("default", "default"),
            NativeBlockValuePickerOption("monospaced", "monospaced"),
            NativeBlockValuePickerOption("rounded", "rounded"),
            NativeBlockValuePickerOption("serif", "serif"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var fontDesign: String = "default"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var fontSize: CGFloat = 16
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var foregroundColor: String = "#ff000000"
    @NativeBlockProp
    var backgroundColor: String = "#00000000"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "LTR"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction")
    )
    var direction: String = "LTR"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingTop: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingLeading: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingBottom: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingTrailing: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameWidth: String = "notSet"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameHeight: String = "notSet"
    @NativeBlockProp
    var cornerRadius: CGFloat = 8.0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "leading"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentVertical: String = "top"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var multilineTextAlignment: String = "leading"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var lineLimit: Int = 9999
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var lineSpacing: CGFloat = 0

    init(
        text: String, placeholder: String, isEditing: Bool, onCommit: @escaping () -> Void, onEditingChanged: @escaping (Bool) -> Void,
        onChange: @escaping (String) -> Void, isSecure: Bool, keyboardType: String, autocapitalization: String, disableAutocorrection: Bool,
        fontFamily: String, fontWeight: String, fontDesign: String, fontSize: CGFloat, foregroundColor: String, backgroundColor: String,
        direction: String, paddingTop: CGFloat, paddingLeading: CGFloat, paddingBottom: CGFloat, paddingTrailing: CGFloat,
        frameWidth: String, frameHeight: String, cornerRadius: CGFloat, alignmentHorizontal: String, alignmentVertical: String,
        multilineTextAlignment: String, lineLimit: Int, lineSpacing: CGFloat
    ) {
        self.text = text
        self.localText = text
        self.isEditing = isEditing
        self.onCommit = onCommit
        self.onEditingChanged = onEditingChanged
        self.onChange = onChange
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.disableAutocorrection = disableAutocorrection
        self.fontFamily = fontFamily
        self.fontWeight = fontWeight
        self.fontDesign = fontDesign
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.direction = direction
        self.paddingTop = paddingTop
        self.paddingLeading = paddingLeading
        self.paddingBottom = paddingBottom
        self.paddingTrailing = paddingTrailing
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.cornerRadius = cornerRadius
        self.alignmentHorizontal = alignmentHorizontal
        self.alignmentVertical = alignmentVertical
        self.multilineTextAlignment = multilineTextAlignment
        self.lineLimit = lineLimit
        self.lineSpacing = lineSpacing
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
                .foregroundColor(Color(blockHex: foregroundColor) ?? Color.black.opacity(0))
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
                .blockMultilineTextAlignment(multilineTextAlignment)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)
                .blockDirection(direction)

                TextField("", text: $localText) { _ in
                }
                .opacity(0.0)
                .blockKeyboardType(keyboardType)
                .blockAutocapitalization(autocapitalization)
                .disableAutocorrection(disableAutocorrection)
                .blockMultilineTextAlignment(multilineTextAlignment)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)
                .blockDirection(direction)
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
                .foregroundColor(Color(blockHex: foregroundColor) ?? Color.black.opacity(0))
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
                .blockMultilineTextAlignment(multilineTextAlignment)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)
                .blockDirection(direction)
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
                fontWeight: "bold",
                fontDesign: "monospaced",
                fontSize: 20,
                foregroundColor: "#ff0000ff",
                multilineTextAlignment: "leading",
                lineLimit: 3,
                lineSpacing: 9,
                direction: "LTR",
                paddingTop: 8,
                paddingLeading: 8,
                paddingBottom: 8,
                paddingTrailing: 8,
                frameWidth: "infinity",
                frameHeight: "notSet"
            )
            NativeTextField(
                text: text,
                placeholder: "Enter text",
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
                keyboardType: "default",
                autocapitalization: "none",
                disableAutocorrection: false,
                fontFamily: "system",
                fontWeight: "regular",
                fontDesign: "default",
                fontSize: 16,
                foregroundColor: "#ff000000",
                backgroundColor: "#ffffff",
                direction: "LTR",
                paddingTop: 10,
                paddingLeading: 16,
                paddingBottom: 10,
                paddingTrailing: 10,
                frameWidth: "infinity",
                frameHeight: "notSet",
                cornerRadius: 8.0,
                alignmentHorizontal: "leading",
                alignmentVertical: "top",
                multilineTextAlignment: "leading",
                lineLimit: 1,
                lineSpacing: 0
            )
        }
    }
}

struct NativeTextField_Previews: PreviewProvider {
    static var previews: some View {
        NativeTextFieldTest()
            .previewLayout(.sizeThatFits)
    }
}
