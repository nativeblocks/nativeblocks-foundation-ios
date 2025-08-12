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
    // MARK: - Datas

    @NativeBlockData(
        description: "Enable or disable the checkbox.",
        defaultValue: "true"
    )
    var enable: Bool = true

    @NativeBlockData(
        description: "Whether the checkbox is initially checked.",
        defaultValue: "false"
    )
    var isChecked: Bool = false

    // MARK: - Events

    @NativeBlockEvent(
        description: "Fires when the checkbox is toggled.",
        dataBinding: ["isChecked"]
    )
    var onChange: (Bool) -> Void

    // MARK: - Props

    @NativeBlockProp(
        description: "Size of the checkbox.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "20"
    )
    var size: CGFloat = 20

    @NativeBlockProp(
        description: "Color when checked.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Check"),
        defaultValue: "#007AFF"
    )
    var checkedColor: Color = .blue

    @NativeBlockProp(
        description: "Color when unchecked.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Check"),
        defaultValue: "#FF888888"
    )
    var uncheckedColor: Color = .gray

    @NativeBlockProp(
        description: "Color of the checkmark.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Check"),
        defaultValue: "#FFFFFF"
    )
    var checkmarkColor: Color = .white

    @NativeBlockProp(
        description: "Color when disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Check"),
        defaultValue: "#FFCCCCCC"
    )
    var disabledColor: Color = .gray

    @NativeBlockProp(
        description: "Corner radius of the checkbox.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "4"
    )
    var cornerRadius: CGFloat = 4

    @NativeBlockProp(
        description: "Top padding.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTop: CGFloat = 8

    @NativeBlockProp(
        description: "Leading padding.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingLeading: CGFloat = 8

    @NativeBlockProp(
        description: "Bottom padding.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingBottom: CGFloat = 8

    @NativeBlockProp(
        description: "Trailing padding.",
        valuePicker: NativeBlockValuePicker.NUMBER_INPUT,
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTrailing: CGFloat = 8

    // MARK: - Body
    var body: some View {
        Button(action: {
            onChange(!isChecked)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(enable ? uncheckedColor : disabledColor, lineWidth: isChecked && enable ? 0 : 1)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(isChecked && enable ? checkedColor : Color.clear)
                    )
                    .frame(width: size, height: size)

                if isChecked && enable {
                    Image(systemName: "checkmark")
                        .foregroundColor(checkmarkColor)
                        .font(.system(size: size * 0.6, weight: .bold))
                }
            }
            .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
        .padding(.top, paddingTop)
        .padding(.leading, paddingLeading)
        .padding(.bottom, paddingBottom)
        .padding(.trailing, paddingTrailing)
        .disabled(!enable)
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
                    size: 24,
                    checkedColor: .green,
                )

                NativeCheckbox(
                    isChecked: isChecked2,
                    onChange: { value in
                        isChecked2 = value
                        print("Checkbox 2 changed to \(value)")
                    },
                    size: 20,
                    checkedColor: .blue,
                )

                NativeCheckbox(
                    isChecked: isChecked3,
                    onChange: { value in
                        isChecked3 = value
                        print("Checkbox 3 changed to \(value)")
                    },
                    size: 16,
                    checkedColor: .red,
                    checkmarkColor: .black
                )

                NativeCheckbox(
                    enable: false,
                    isChecked: isChecked4,
                    onChange: { value in
                        isChecked4 = value
                        print("Checkbox 4 changed to \(value)")
                    },
                    size: 12
                )
            }
        }
    }
}
