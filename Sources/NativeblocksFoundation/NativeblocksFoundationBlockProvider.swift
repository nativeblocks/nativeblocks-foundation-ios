import Nativeblocks
import SwiftUI

public class NativeblocksFoundationBlockProvider {
    public static func provideBlocks() {
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/IMAGE", block: NativeImageBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/ZSTACK", block: NativeZStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/SCROLLVIEW", block: NativeScrollViewBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/TEXT", block: NativeTextBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/SPACER", block: NativeSpacerBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/LAZY_VSTACK", block: NativeLazyVStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/LAZY_HSTACK", block: NativeLazyHStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/VSTACK", block: NativeVStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/HSTACK", block: NativeHStackBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/TEXT_FIELD", block: NativeTextFieldBlock())
        NativeblocksManager.getInstance().provideBlock(blockkeyType: "nativeblocks/BUTTON", block: NativeButtonBlock())
    }
}
