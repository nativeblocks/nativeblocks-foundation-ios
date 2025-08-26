import Nativeblocks

public class NativeblocksFoundationActionProvider {
    public static func provideActions(name: String = "default") {
        _ = NativeblocksManager.getInstance(name: name).provideAction(
            actionKeyType: "nativeblocks/change_block_property",
            action: NativeChangeBlockPropertyAction(action: NativeChangeBlockProperty()))
        _ = NativeblocksManager.getInstance(name: name).provideAction(
            actionKeyType: "nativeblocks/change_variable",
            action: NativeChangeVariableAction(action: NativeChangeVariable()))
    }
}
