import Nativeblocks

public class NativeblocksFoundationBlockProvider {
    public static func provideBlocks(name: String = "default") {
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/image") { props in
            NativeImageBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/zstack") { props in
            NativeZStackBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/scrollview") { props in
            NativeScrollViewBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/text") { props in
            NativeTextBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/dropdown") { props in
            NativeDropdownBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/spacer") { props in
            NativeSpacerBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/lazy_vstack") { props in
            NativeLazyVStackBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/lazy_hstack") { props in
            NativeLazyHStackBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/radio_group") { props in
            NativeRadioGroupBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/vstack") { props in
            NativeVStackBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/hstack") { props in
            NativeHStackBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/text_field") { props in
            NativeTextFieldBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/button") { props in
            NativeButtonBlock(blockProps: props)
        }
        _ = NativeblocksManager.getInstance(name: name).provideBlock(blockKeyType: "nativeblocks/checkbox") { props in
            NativeCheckboxBlock(blockProps: props)
        }
    }
}
