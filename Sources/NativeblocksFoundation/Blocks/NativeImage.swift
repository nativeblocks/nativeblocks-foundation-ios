import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeBlock(
    name: "Native Image",
    keyType: "NATIVE_IMAGE",
    description: "Nativeblocks image block",
    version: 1
)
struct NativeImage: View {
    @NativeBlockData
    var imageUrl: String
    @NativeBlockData
    var contentDescription: String = ""
    @NativeBlockProp()
    var aspectRatio: CGFloat = 0
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("fill", "fill"),
            NativeBlockValuePickerOption("fit", "fit"),
        ]
    )
    var contentMode: String = "fit"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("notSet", "notSet"),
            NativeBlockValuePickerOption("stretch", "stretch"),
            NativeBlockValuePickerOption("tile", "tile"),
        ]
    )
    var resizable: String = "stretch"
    @NativeBlockProp(
        valuePicker: NativeBlockValuePicker.DROPDOWN,
        valuePickerOptions: [
            NativeBlockValuePickerOption("none", "none"),
            NativeBlockValuePickerOption("high", "high"),
            NativeBlockValuePickerOption("low", "low"),
            NativeBlockValuePickerOption("medium", "medium"),
        ]
    )
    var interpolation: String = "none"
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
    var backgroundColor: String = "#00000000"
    @NativeBlockProp(valuePickerGroup: NativeBlockValuePickerPosition("Background"))
    var cornerRadius: CGFloat = 0

    var body: some View {
        let shape = roundedRectangleShape(cornerRadius)
        let background = Color(blockHex: backgroundColor) ?? Color.black.opacity(0)
        if imageUrl.isValidImageUrl() {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    HStack(alignment: .center) {
                        ProgressView()
                    }
                    .blockWidthAndHeightModifier(frameWidth, frameHeight)
                    .background(background)
                    .clipShape(shape)
                case .success(let image):
                    image.resizable()
                        .blockResizable(resizable)
                        .blockInterpolation(interpolation)
                        .blockWidthAndHeightModifier(frameWidth, frameHeight)
                        .blockAspectRatio(ratio: aspectRatio, mode: contentMode)
                        .contentShape(.rect)
                        .background(background)
                        .clipShape(shape)
                case .failure:
                    EmptyView()
                        .blockWidthAndHeightModifier(frameWidth, frameHeight)
                        .background(background)
                        .clipShape(shape)
                @unknown default:
                    EmptyView()
                        .blockWidthAndHeightModifier(frameWidth, frameHeight)
                        .background(background)
                        .clipShape(shape)
                }
            }
            .accessibility(label: Text(contentDescription))
        } else {
            EmptyView()
                .blockWidthAndHeightModifier(frameWidth, frameHeight)
                .background(background)
                .clipShape(shape)
        }
    }
}

#Preview("NativeImage") {
    NativeImage(
        imageUrl: "https://picsum.photos/seed/picsum/300/200",
        contentDescription: "",
        aspectRatio: 0,
        contentMode: "fit",
        resizable: "stretch",
        interpolation: "none",
        frameWidth: "200",
        frameHeight: "200",
        backgroundColor: "#00000000",
        cornerRadius: 0
    )
}

#Preview("NativeImage scale") {
    NativeImage(
        imageUrl: "https://picsum.photos/seed/picsum/600/200",
        contentMode: "fill",
        frameWidth: "200",
        frameHeight: "200"
    )
}

#Preview("NativeImage aspectRatio") {
    NativeImage(
        imageUrl: "https://picsum.photos/seed/picsum/600/200",
        aspectRatio: 3,
        contentMode: "fit",
        frameWidth: "200",
        frameHeight: "200"
    )
}

#Preview("NativeImage faile") {
    NativeImage(
        imageUrl: "https://picsum.photos/seed/picsum/600/200",
        frameWidth: "200",
        frameHeight: "200",
        backgroundColor: "#ff0000ff",
        cornerRadius: 200
    )
}
