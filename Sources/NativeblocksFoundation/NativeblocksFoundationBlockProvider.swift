import Nativeblocks
public class NativeblocksFoundationBlockProvider {
    public static func provideBlocks() {
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_TEXT", block: NativeTextBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "NATIVE_VSTACK", block: NativeVStackBlock())
    }
}