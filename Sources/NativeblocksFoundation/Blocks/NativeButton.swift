import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Button",
    keyType: "NATIVE_BUTTON",
    description: "Nativeblocks Button block",
    version: 2
)
struct NativeButton<Content: View>: View {
    @NativeBlockData
    var text: String
    @NativeBlockSlot
    var leadingIcon: ((BlockIndex) -> Content)? = nil
    @NativeBlockSlot
    var trailingIcon: ((BlockIndex) -> Content)? = nil
    @NativeBlockData
    var disabled: Bool = false
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "center"
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
    var alignmentVertical: String = "center"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Alignment"))
    var spacing: CGFloat = 6
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
    var foregroundColor: String = "#ffffffff"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var disableForegroundColor: String = "#ff000000"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var multilineTextAlignment: String = "center"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var lineLimit: Int = 9999
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Font"))
    var lineSpacing: CGFloat = 0
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
    var paddingTop: CGFloat = 8
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingLeading: CGFloat = 8
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingBottom: CGFloat = 8
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Padding"))
    var paddingTrailing: CGFloat = 8
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
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#ff000ff0"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var disableBackgroundColor: String = "#c1c1c1"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var cornerRadius: CGFloat = 4
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var disablBorderColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var borderWidth: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var shadowRadius: CGFloat = 0
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var shadowX: CGFloat = 2
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var shadowY: CGFloat = 2
    @NativeBlockEvent
    var onClick: () -> Void
    var body: some View {
        let background = Color(blockHex: disabled ? disableBackgroundColor : backgroundColor) ?? Color.black.opacity(0)

        let border = Color(blockHex: disabled ? disablBorderColor : borderColor) ?? Color.black.opacity(0)

        let foreground = Color(blockHex: disabled ? disableForegroundColor : foregroundColor) ?? Color.black.opacity(0)

        Button(action: {
            if !disabled {
                onClick()
            }
        }) {
            HStack(alignment: mapBlockVerticalAlignment(alignmentVertical), spacing: spacing) {
                leadingIcon?(-1)
                Text(text)
                    .blockFont(
                        family: fontFamily,
                        size: fontSize,
                        weight: fontWeight,
                        design: fontDesign
                    )
                    .foregroundColor(foreground)
                    .blockMultilineTextAlignment(multilineTextAlignment)
                    .lineLimit(lineLimit)
                    .lineSpacing(lineSpacing)
                trailingIcon?(-1)
            }
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
        }

        .disabled(disabled)
        .background(background)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(
                cornerRadius:
                    cornerRadius
            ).stroke(
                border,
                lineWidth: borderWidth
            )
        )
        .shadow(
            color: Color(blockHex: shadowColor) ?? Color.black.opacity(0),
            radius: shadowRadius, x: shadowX, y: shadowY
        )
        .blockDirection(direction)
        .buttonStyle(PlainButtonStyle())
    }
}

struct NativeButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            NativeButton(
                text: "Enable Action",
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
                onClick: {}
            )

            NativeButton(
                text: "Disable Action",
                leadingIcon: { _ in
                    EmptyView()
                },
                trailingIcon: { _ in
                    EmptyView()
                },
                disabled: true,
                onClick: {}
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
