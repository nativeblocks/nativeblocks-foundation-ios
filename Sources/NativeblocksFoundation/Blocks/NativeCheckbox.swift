import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable checkbox block for Nativeblocks.
///
/// `NativeCheckbox` provides a simple checkbox that reflects and updates its checked state.
/// You can configure its label, initial state, size, color, and also attach an event handler.
///
/// ### Features:
/// - Toggle checkbox with visual feedback
/// - Configurable label, color, and size
/// - State synchronization with Nativeblocks data
/// - Action callback when toggled
///
/// ### Example:
/// ```swift
/// NativeCheckbox(
///     label: "Accept Terms",
///     isChecked: true,
///     onChange: { checked in
///         print("Checkbox is now \(checked)")
///     }
/// )
/// ```
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

    @NativeBlockProp(
        description: "Text label displayed next to the checkbox.",
        defaultValue: "Label"
    )
    var label: String = "Label"

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
                                .fill(isOnInternal  ? checkedColor : Color.clear)
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
