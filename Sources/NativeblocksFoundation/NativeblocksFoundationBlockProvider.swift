import Nativeblocks

public class NativeblocksFoundationBlockProvider {
    public static func provideBlocks() {
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_IMAGE", block: NativeImageBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_ZSTACK", block: NativeZStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_TEXT", block: NativeTextBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_SPACER", block: NativeSpacerBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_VSTACK", block: NativeVStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_HSTACK", block: NativeHStackBlock())
    }
}
