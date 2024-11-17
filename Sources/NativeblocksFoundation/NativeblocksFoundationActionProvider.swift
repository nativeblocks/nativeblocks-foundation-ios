import Nativeblocks

public class NativeblocksFoundationActionProvider {
    public static func provideActions(nativeChangeBlockProperty: NativeChangeBlockProperty, nativeChangeVariable: NativeChangeVariable) {
        NativeblocksManager.getInstance().provideAction(
            actionKeyType: "NATIVE_CHANGE_BLOCK_PROPERTY", action: NativeChangeBlockPropertyAction(action: nativeChangeBlockProperty))
        NativeblocksManager.getInstance().provideAction(
            actionKeyType: "NATIVE_CHANGE_VARIABLE", action: NativeChangeVariableAction(action: nativeChangeVariable))
    }
}
