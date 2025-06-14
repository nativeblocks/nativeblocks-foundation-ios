import Nativeblocks
public class NativeblocksFoundationActionProvider {
    public static func provideActions() {
        NativeblocksManager.getInstance().provideAction(actionKeyType: "nativeblocks/change_block_property", action: NativeChangeBlockPropertyAction(action: NativeChangeBlockProperty()))
        NativeblocksManager.getInstance().provideAction(actionKeyType: "nativeblocks/change_variable", action: NativeChangeVariableAction(action: NativeChangeVariable()))
    }
}
