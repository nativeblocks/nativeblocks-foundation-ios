import Nativeblocks
public class NativeblocksFoundationBlockProvider {
    public static func provideBlocks() {
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/image", block: NativeImageBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/zstack", block: NativeZStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/scrollview", block: NativeScrollViewBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/text", block: NativeTextBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/spacer", block: NativeSpacerBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/lazy_vstack", block: NativeLazyVStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/lazy_hstack", block: NativeLazyHStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/vstack", block: NativeVStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/hstack", block: NativeHStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/text_field", block: NativeTextFieldBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/button", block: NativeButtonBlock())
    }
}
