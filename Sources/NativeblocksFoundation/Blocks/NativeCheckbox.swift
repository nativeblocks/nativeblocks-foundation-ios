import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Checkbox",
    keyType: "nativeblocks/checkbox",
    description: "A simple checkbox component for Nativeblocks.",
    version: 1,
    versionName: "1.0.0"
)
struct NativeCheckbox: View {
    var blockProps: BlockProps? = nil
    // MARK: - Datas

    @NativeBlockData(
        description: "When false, the checkbox is disabled and non-interactive.",
        defaultValue: "true"
    )
    var enable: Bool = true

    @NativeBlockData(
        description: "Initial state of the checkbox.",
        defaultValue: "false"
    )
    var isChecked: Bool = false

    // MARK: - Events

    @NativeBlockEvent(
        description: "Callback triggered when the checkbox is toggled.",
        dataBinding: ["isChecked"]
    )
    var onChange: (Bool) -> Void

    // MARK: - Props

    @NativeBlockData(
        description: "Text label displayed next to the checkbox.",
        defaultValue: "",
    )
    var label: String = ""

    @NativeBlockProp(
        description: "Defines the width of the layout container. Use 'auto' for intrinsic width or 'fill' to expand fully in its parent.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    @NativeBlockProp(
        description:
            "Defines the height of the layout container. Use 'auto' for intrinsic height or 'fill' to occupy all available vertical space.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var height: String = "auto"

    @NativeBlockProp(
        description: "Weight value for layout distribution in horizontal or vertical stacks. Use 0 for no weight.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "0.0"
    )
    var weight: CGFloat = 0.0

    @NativeBlockProp(
        description: "Size of the checkbox square.",
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "20"
    )
    var size: CGFloat = 20

    @NativeBlockProp(
        description: "Tint color when checkbox is checked.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        defaultValue: "#007AFF"
    )
    var checkedColor: Color = Color.blue

    @NativeBlockProp(
        description: "The font family for the checkbox lable.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "system"
    )
    var fontFamily: String = "system"

    @NativeBlockProp(
        description: "The weight of the font used for the checkbox lable.",
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
    var fontWeight: Font.Weight = Font.Weight.regular

    @NativeBlockProp(
        description: "Specifies the font design for the checkbox lable.",
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
    var fontDesign: Font.Design = Font.Design.default

    @NativeBlockProp(
        description: "The font size for the checkbox lable.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "16"
    )
    var fontSize: CGFloat = 16

    @NativeBlockProp(
        description: "The color of the lable when the checkbox is enabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#ff000000"
    )
    var foregroundColor: Color = .black

    @NativeBlockProp(
        description: "Specifies how multi-line text in the checkbox is aligned.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "center"
    )
    var multilineTextAlignment: TextAlignment = TextAlignment.center

    @NativeBlockProp(
        description: "Padding at the top edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTop: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the leading edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingLeading: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the bottom edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingBottom: CGFloat = 8

    @NativeBlockProp(
        description: "Padding at the trailing edge of the layout container.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTrailing: CGFloat = 8

    // MARK: - State
    @State private var isOnInternal: Bool = false

    private var isOn: Binding<Bool> {
        Binding<Bool>(
            get: { isOnInternal },
            set: { newValue in
                isOnInternal = newValue
                onChange(newValue)
            }
        )
    }

    // MARK: - Body
    var body: some View {
        HStack {
            Button(action: {
                if enable {
                    isOn.wrappedValue.toggle()
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .strokeBorder(Color.gray, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(isOnInternal ? checkedColor : Color.clear)
                        )
                        .frame(width: size, height: size)

                    if isOnInternal {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: size * 0.6, weight: .bold))
                    }
                }

                Text(label)
                    .blockFont(family: fontFamily, size: fontSize, weight: fontWeight, design: fontDesign)
                    .foregroundColor(foregroundColor)
                    .lineLimit(3)
                    .multilineTextAlignment(multilineTextAlignment)
            }
            .buttonStyle(.plain)
        }
        .blockWidthAndHeightModifier(width, height)
        .weighted(weight, proxy: blockProps?.hierarchy?.last?.scope)
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .disabled(!enable)
        .onAppear {
            isOnInternal = isChecked
        }
    }
}
struct NativeCheckbox_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

    static var previews: some View {
        CheckboxPreviewContainer()
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color(white: 0.95))
    }

    struct CheckboxPreviewContainer: View {
        @State private var isChecked1 = true
        @State private var isChecked2 = false
        @State private var isChecked3 = true
        @State private var isChecked4 = true

        var body: some View {
            VStack(spacing: 20) {
                NativeCheckbox(
                    isChecked: isChecked1,
                    onChange: { value in
                        isChecked1 = value
                        print("Checkbox 1 changed to \(value)")
                    },
                    label: "Subscribe to newsletter",
                    size: 24,
                    checkedColor: .green,
                    fontWeight: .bold,
                    fontSize: 24,
                )

                NativeCheckbox(
                    isChecked: isChecked2,
                    onChange: { value in
                        isChecked2 = value
                        print("Checkbox 2 changed to \(value)")
                    },
                    label: "Accept terms and conditions",
                    size: 20,
                    checkedColor: .blue,
                    fontSize: 20,
                )

                NativeCheckbox(
                    isChecked: isChecked3,
                    onChange: { value in
                        isChecked3 = value
                        print("Checkbox 3 changed to \(value)")
                    },
                    label: "Enable\n notifications",
                    size: 16,
                    checkedColor: .red,
                    fontSize: 16,
                    multilineTextAlignment: TextAlignment.leading
                )

                NativeCheckbox(
                    enable: false,
                    isChecked: isChecked4,
                    onChange: { value in
                        isChecked4 = value
                        print("Checkbox 4 changed to \(value)")
                    },
                    label: "Disable notifications",
                    size: 12,
                    checkedColor: .red,
                    fontSize: 12,
                )
            }
        }
    }
}
