import Nativeblocks

public class NativeblocksFoundationActionProvider {
    public static func provideActions() {
        NativeblocksManager.getInstance().provideAction(
            actionKeyType: "NATIVE_CHANGE_BLOCK_PROPERTY", action: NativeChangeBlockPropertyAction(action: NativeChangeBlockProperty()))
        NativeblocksManager.getInstance().provideAction(
            actionKeyType: "NATIVE_CHANGE_VARIABLE", action: NativeChangeVariableAction(action: NativeChangeVariable()))
    }
}
