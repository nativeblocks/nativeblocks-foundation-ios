import Nativeblocks
import SwiftUI

public class NativeblocksFoundationBlockProvider {
    public static func provideBlocks() {
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/IMAGE", block: NativeImageBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/ZSTACK", block: NativeZStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/SCROLLVIEW", block: NativeScrollViewBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/TEXT", block: NativeTextBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/SPACER", block: NativeSpacerBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/LAZY_VSTACK", block: NativeLazyVStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/LAZY_HSTACK", block: NativeLazyHStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/VSTACK", block: NativeVStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/HSTACK", block: NativeHStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/TEXT_FIELD", block: NativeTextFieldBlock())
        NativeblocksManager.getInstance().provideBlock(blockKeyType: "nativeblocks/BUTTON", block: NativeButtonBlock())
    }
}
