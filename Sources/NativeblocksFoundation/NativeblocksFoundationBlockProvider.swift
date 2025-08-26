import Nativeblocks


public class NativeblocksFoundationBlockProvider {
    public static func provideBlocks(name: String = "default") {
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/image", block: NativeImageBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/zstack", block: NativeZStackBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/scrollview", block: NativeScrollViewBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/text", block: NativeTextBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/dropdown", block: NativeDropdownBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/spacer", block: NativeSpacerBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/lazy_vstack", block: NativeLazyVStackBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/lazy_hstack", block: NativeLazyHStackBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/radio_group", block: NativeRadioGroupBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/vstack", block: NativeVStackBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/hstack", block: NativeHStackBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/text_field", block: NativeTextFieldBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/button", block: NativeButtonBlock())
        NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/checkbox", block: NativeCheckboxBlock())
    }
}
