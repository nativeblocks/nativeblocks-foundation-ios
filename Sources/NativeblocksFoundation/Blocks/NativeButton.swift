import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A customizable button block for Nativeblocks.
///
/// `NativeButton` is a flexible and configurable button block that integrates with the Nativeblocks ecosystem.
/// It supports features like custom icons, font styles, colors, padding, shadows, and more.
///
/// ### Features:
/// - Customizable alignment, font, colors, padding, and shadows.
/// - Support for both leading and trailing icons.
/// - Dynamic properties configured via Nativeblocks Studio.
/// - Handles enabled and disabled states.
/// - Triggers an action when clicked.
///
/// ### Example:
/// ```swift
/// NativeButton(
///     text: "Click Me",
///     onClick: { print("Button clicked") }
/// )
/// ```
@NativeBlock(
    name: "Native Button",
    keyType: "NATIVE_BUTTON",
    description: "Nativeblocks Button block",
    version: 2
)
struct NativeButton<Content: View>: View {
    /// The text displayed on the button.
    @NativeBlockData(description: "The primary text content of the button.")
    var text: String

    /// An optional leading icon displayed in the button.
    @NativeBlockSlot(description: "A view that appears as the leading icon of the button.")
    var leadingIcon: ((BlockIndex) -> Content)? = nil

    /// An optional trailing icon displayed in the button.
    @NativeBlockSlot(description: "A view that appears as the trailing icon of the button.")
    var trailingIcon: ((BlockIndex) -> Content)? = nil

    /// Determines whether the button is disabled.
    @NativeBlockData(description: "When fale, the button is disabled and non-interactive.")
    var enable: Bool = false

    /// The horizontal alignment of the button content.
    @NativeBlockProp(
        description: "Specifies the horizontal alignment of the button content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentHorizontal: String = "center"

    /// The vertical alignment of the button content.
    @NativeBlockProp(
        description: "Specifies the vertical alignment of the button content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("top", "top"),
            NativeBlockValuePickerOption("bottom", "bottom"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("firstTextBaseline", "firstTextBaseline"),
            NativeBlockValuePickerOption("lastTextBaseline", "lastTextBaseline"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var alignmentVertical: String = "center"

    /// The spacing between elements inside the button.
    @NativeBlockProp(
        description: "The spacing between elements inside the button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment")
    )
    var spacing: CGFloat = 6

    /// The font family of the button text.
    @NativeBlockProp(
        description: "The font family for the button text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var fontFamily: String = "system"

    /// The weight of the font for the button text.
    @NativeBlockProp(
        description: "The weight of the font used for the button text.",
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

    /// The design of the font for the button text.
    @NativeBlockProp(
        description: "Specifies the font design for the button text.",
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

    /// The size of the font for the button text.
    @NativeBlockProp(
        description: "The font size for the button text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var fontSize: CGFloat = 16

    /// The foreground color of the button text.
    @NativeBlockProp(
        description: "The color of the text when the button is enabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var foregroundColor: String = "#ffffffff"

    /// The foreground color of the button text when disabled.
    @NativeBlockProp(
        description: "The color of the text when the button is disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var disableForegroundColor: String = "#ff000000"

    /// The alignment of multi-line text in the button.
    @NativeBlockProp(
        description: "Specifies how multi-line text in the button is aligned.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("center", "center"),
            NativeBlockValuePickerOption("trailing", "trailing"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var multilineTextAlignment: String = "center"

    /// The maximum number of lines for the button text.
    @NativeBlockProp(
        description: "The maximum number of lines for the button text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var lineLimit: Int = 9999

    /// The spacing between lines of the button text.
    @NativeBlockProp(
        description: "The spacing between lines of text in the button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font")
    )
    var lineSpacing: CGFloat = 0

    /// The layout direction of the button (LTR or RTL).
    @NativeBlockProp(
        description: "Specifies the layout direction of the button content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("LTR", "LTR"),
            NativeBlockValuePickerOption("RTL", "RTL"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Direction")
    )
    var direction: String = "LTR"

    /// The top padding of the button content.
    @NativeBlockProp(
        description: "The top padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTop: CGFloat = 8

    /// The leading (left) padding of the button content.
    @NativeBlockProp(
        description: "The leading padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingLeading: CGFloat = 8

    /// The bottom padding of the button content.
    @NativeBlockProp(
        description: "The bottom padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingBottom: CGFloat = 8

    /// The trailing (right) padding of the button content.
    @NativeBlockProp(
        description: "The trailing padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding")
    )
    var paddingTrailing: CGFloat = 8

    /// The width of the button's frame.
    @NativeBlockProp(
        description: "The width of the button frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameWidth: String = "notSet"

    /// The height of the button's frame.
    @NativeBlockProp(
        description: "The height of the button frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("infinity", "infinity"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size")
    )
    var frameHeight: String = "notSet"

    /// The background color of the button when enabled.
    @NativeBlockProp(
        description: "The background color of the button when enabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var backgroundColor: String = "#ff000ff0"

    /// The background color of the button when disabled.
    @NativeBlockProp(
        description: "The background color of the button when disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var disableBackgroundColor: String = "#c1c1c1"

    /// The corner radius of the button.
    @NativeBlockProp(
        description: "The corner radius of the button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var cornerRadius: CGFloat = 4

    /// The border color of the button when enabled.
    @NativeBlockProp(
        description: "The border color of the button when enabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderColor: String = "#00000000"

    /// The border color of the button when disabled.
    @NativeBlockProp(
        description: "The border color of the button when disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var disablBorderColor: String = "#00000000"

    /// The width of the button's border.
    @NativeBlockProp(
        description: "The width of the button border.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var borderWidth: CGFloat = 0

    /// The shadow color of the button.
    @NativeBlockProp(
        description: "The shadow color of the button.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowColor: String = "#00000000"

    /// The blur radius of the button's shadow.
    @NativeBlockProp(
        description: "The blur radius of the button shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal offset of the shadow.
    @NativeBlockProp(
        description: "The horizontal offset of the button shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowX: CGFloat = 2

    /// The vertical offset of the shadow.
    @NativeBlockProp(
        description: "The vertical offset of the button shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background")
    )
    var shadowY: CGFloat = 2

    /// The action triggered when the button is clicked.
    @NativeBlockEvent(description: "The action triggered when the button is clicked.")
    var onClick: (() -> Void)?

    var body: some View {
        let background = Color(blockHex: !enable ? disableBackgroundColor : backgroundColor) ?? Color.black.opacity(0)

        let border = Color(blockHex: !enable ? disablBorderColor : borderColor) ?? Color.black.opacity(0)

        let foreground = Color(blockHex: !enable ? disableForegroundColor : foregroundColor) ?? Color.black.opacity(0)

        Button(action: {
            if enable {
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

        .disabled(!enable)
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
                enable: true,
                onClick: {}
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
