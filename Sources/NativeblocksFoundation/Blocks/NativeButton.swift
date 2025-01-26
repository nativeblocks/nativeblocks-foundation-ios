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
    @NativeBlockData(
        description: "When true, the button is disabled and non-interactive.",
        defaultValue: "true"
    )
    var enable: Bool = true

    /// The horizontal alignment of the button content.
    @NativeBlockProp(
        description: "Specifies the horizontal alignment of the button content.",
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("leading", "leading"),
            NativeBlockValuePickerOption("trailing", "trailing"),
            NativeBlockValuePickerOption("center", "center"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "center"
    )
    var alignmentHorizontal: HorizontalAlignment = HorizontalAlignment.center

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
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "center"
    )
    var alignmentVertical: VerticalAlignment = VerticalAlignment.center

    /// The spacing between elements inside the button.
    @NativeBlockProp(
        description: "The spacing between elements inside the button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Alignment"),
        defaultValue: "6"
    )
    var spacing: CGFloat = 6

    /// The font family of the button text.
    @NativeBlockProp(
        description: "The font family for the button text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "system"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "regular"
    )
    var fontWeight: Font.Weight = Font.Weight.regular

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
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "default"
    )
    var fontDesign: Font.Design = Font.Design.default

    /// The size of the font for the button text.
    @NativeBlockProp(
        description: "The font size for the button text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "16"
    )
    var fontSize: CGFloat = 16

    /// The foreground color of the button text.
    @NativeBlockProp(
        description: "The color of the text when the button is enabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#ffffffff"
    )
    var foregroundColor: Color = .white

    /// The foreground color of the button text when disabled.
    @NativeBlockProp(
        description: "The color of the text when the button is disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "#ff000000"
    )
    var disableForegroundColor: Color = .black

    /// The alignment of multi-line text in the button.
    @NativeBlockProp(
        description: "Specifies how multi-line text in the button is aligned.",
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

    /// The maximum number of lines for the button text.
    @NativeBlockProp(
        description: "The maximum number of lines for the button text.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "9999"
    )
    var lineLimit: Int = 9999

    /// The spacing between lines of the button text.
    @NativeBlockProp(
        description: "The spacing between lines of text in the button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Font"),
        defaultValue: "0"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Direction"),
        defaultValue: "LTR"
    )
    var direction: LayoutDirection = LayoutDirection.leftToRight

    /// The top padding of the button content.
    @NativeBlockProp(
        description: "The top padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingTop: CGFloat = 8

    /// The leading (left) padding of the button content.
    @NativeBlockProp(
        description: "The leading padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingLeading: CGFloat = 8

    /// The bottom padding of the button content.
    @NativeBlockProp(
        description: "The bottom padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
    )
    var paddingBottom: CGFloat = 8

    /// The trailing (right) padding of the button content.
    @NativeBlockProp(
        description: "The trailing padding of the button content.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "8"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
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
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "notSet"
    )
    var frameHeight: String = "notSet"

    /// The background color of the button when enabled.
    @NativeBlockProp(
        description: "The background color of the button when enabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#ff000ff0"
    )
    var backgroundColor: Color = .blue

    /// The background color of the button when disabled.
    @NativeBlockProp(
        description: "The background color of the button when disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#ffc1c1c1"
    )
    var disableBackgroundColor: Color = .gray

    /// The corner radius of the button.
    @NativeBlockProp(
        description: "The corner radius of the button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "4"
    )
    var cornerRadius: CGFloat = 4

    /// The border color of the button when enabled.
    @NativeBlockProp(
        description: "The border color of the button when enabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var borderColor: Color = Color.black.opacity(0)

    /// The border color of the button when disabled.
    @NativeBlockProp(
        description: "The border color of the button when disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var disablBorderColor: Color = Color.black.opacity(0)

    /// The width of the button's border.
    @NativeBlockProp(
        description: "The width of the button border.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var borderWidth: CGFloat = 0

    /// The shadow color of the button.
    @NativeBlockProp(
        description: "The shadow color of the button.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "#00000000"
    )
    var shadowColor: Color = Color.black.opacity(0)

    /// The blur radius of the button's shadow.
    @NativeBlockProp(
        description: "The blur radius of the button shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "0"
    )
    var shadowRadius: CGFloat = 0

    /// The horizontal offset of the shadow.
    @NativeBlockProp(
        description: "The horizontal offset of the button shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "2"
    )
    var shadowX: CGFloat = 2

    /// The vertical offset of the shadow.
    @NativeBlockProp(
        description: "The vertical offset of the button shadow.",
        valuePickerGroup: NativeBlockValuePickerPosition("Background"),
        defaultValue: "2"
    )
    var shadowY: CGFloat = 2

    /// The action triggered when the button is clicked.
    @NativeBlockEvent(description: "The action triggered when the button is clicked.")
    var onClick: (() -> Void)?

    var body: some View {
        let background = !enable ? disableBackgroundColor : backgroundColor

        let border = !enable ? disablBorderColor : borderColor

        let foreground = !enable ? disableForegroundColor : foregroundColor
        Button(action: {
            if enable {
                onClick?()
            }
        }) {
            HStack(alignment: alignmentVertical, spacing: spacing) {
                leadingIcon?(-1)
                Text(text)
                    .blockFont(
                        family: fontFamily,
                        size: fontSize,
                        weight: fontWeight,
                        design: fontDesign
                    )
                    .foregroundColor(foreground)
                    .multilineTextAlignment(multilineTextAlignment)
                    .lineLimit(lineLimit)
                    .lineSpacing(lineSpacing)
                trailingIcon?(-1)
            }
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
            color: shadowColor,
            radius: shadowRadius, x: shadowX, y: shadowY
        )
        .environment(\.layoutDirection, direction)
        .buttonStyle(PlainButtonStyle())
    }
}

struct NativeButton_Previews: PreviewProvider {
    init() {
        NativeblocksFoundationTypeProvider.provideTypes()
    }

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
                onClick: {
                    print("click Action")
                }
            )

            NativeButton(
                text: "Disable Action",
                leadingIcon: { _ in
                    EmptyView()
                },
                trailingIcon: { _ in
                    EmptyView()
                },
                enable: false,
                onClick: {
                    print("click Disable")
                }
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
