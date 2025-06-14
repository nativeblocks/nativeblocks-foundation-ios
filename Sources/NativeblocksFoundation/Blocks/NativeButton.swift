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
    keyType: "nativeblocks/button",
    description: "Nativeblocks Button block",
    version: 1,
    versionName: "1.0.0"
)
struct NativeButton<Content: View>: View {
    var blockProps: BlockProps? = nil
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
        description: "When false, the button is disabled and non-interactive.",
        defaultValue: "true"
    )
    var enable: Bool = true

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

    // MARK: - Padding Properties

    /// Padding at the top of the Button.
    @NativeBlockProp(
        description: "Padding at the top of the Button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTop: CGFloat = 0

    /// Padding at the leading edge of the Button.
    @NativeBlockProp(
        description: "Padding at the leading edge of the Button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingLeading: CGFloat = 0

    /// Padding at the bottom of the Button.
    @NativeBlockProp(
        description: "Padding at the bottom of the Button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingBottom: CGFloat = 0

    /// Padding at the trailing edge of the Button.
    @NativeBlockProp(
        description: "Padding at the trailing edge of the Button.",
        valuePickerGroup: NativeBlockValuePickerPosition("Padding"),
        defaultValue: "0"
    )
    var paddingTrailing: CGFloat = 0

    // MARK: - Size Properties

    /// Width of the Button frame
    @NativeBlockProp(
        description: "Width of the Button frame.",
        valuePicker: NativeBlockValuePicker.COMBOBOX_INPUT,
        valuePickerOptions: [
            NativeBlockValuePickerOption("auto", "auto"),
            NativeBlockValuePickerOption("fill", "fill"),
        ],
        valuePickerGroup: NativeBlockValuePickerPosition("Size"),
        defaultValue: "auto"
    )
    var width: String = "auto"

    /// Height of the Button frame
    @NativeBlockProp(
        description: "Height of the Button frame.",
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

    /// The border color of the button when disabled.
    @NativeBlockProp(
        description: "The border color of the button when disabled.",
        valuePicker: NativeBlockValuePicker.COLOR_PICKER,
        valuePickerGroup: NativeBlockValuePickerPosition("Border"),
        defaultValue: "#00000000"
    )
    var disablBorderColor: Color = Color.black.opacity(0)

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
            HStack(alignment: VerticalAlignment.center) {
                leadingIcon?(-1)
                Text(text)
                    .blockFont(family: fontFamily, size: fontSize, weight: fontWeight, design: fontDesign)
                    .foregroundColor(foreground)
                    .multilineTextAlignment(multilineTextAlignment)
                trailingIcon?(-1)
            }
            .blockWidthAndHeightModifier(width, height)
            .weighted(weight, proxy: blockProps?.hierarchy?.last?.scope)
            .padding(.top, paddingTop)
            .padding(.leading, paddingLeading)
            .padding(.bottom, paddingBottom)
            .padding(.trailing, paddingTrailing)
        }
        .disabled(!enable)
        .background(background)
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
            .stroke(border, lineWidth: borderWidth)
        )
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
