import Nativeblocks
import NativeblocksCompiler

/// A class responsible for changing the variable within the Nativeblocks system.
///
/// The `NativeChangeVariable` class enables the modification of a value dynamically.
/// It supports variable substitution, conditional evaluation, and arithmetic operations for property values.
///
/// Variable Value Supported Formats:
///   - `{var:variable-key}`: Replaces with the value of the variable.
///   - `{index}`: Replaces with the list item index.
///   - `#SCRIPT 2 + 2 #ENDSCRIPT`: The string with evaluated JavaScript code replacing the script tags.
///
@NativeAction(
    name: "Native Change Variable",
    keyType: "nativeblocks/change-variable",
    description: "Native Change Variable",
    version: 1,
    versionName: "1.0.0"
)
public class NativeChangeVariable {
    public init() {}

    /// Parameters required for the `NativeChangeVariable` action.
    @NativeActionParameter()
    struct Parameter {
        /// The key of the variable to be modified.
        @NativeActionData(description: "key of the variable")
        var variableKey: String

        /// The new value to be assigned to the variable.
        @NativeActionProp(description: "value of the variable", valuePicker: .SCRIPT_AREA_INPUT)
        var variableValue: String

        /// Callback triggered after the variable is updated.
        @NativeActionEvent(dataBinding: ["variableKey"], then: .NEXT)
        var onNext: (String) -> Void

        /// Additional properties for the action, such as variables and triggers.
        var actionProps: ActionProps
    }

    /// Function to handle the change of a variable.
    @NativeActionFunction()
    func onChangeBlock(param: Parameter) async {
        // Retrieve data from the action properties.
        let data = param.actionProps.trigger?.data ?? [:]

        guard let variable = param.actionProps.variables?[data["variableKey"]?.value ?? ""] else {
            return
        }

        var value = actionHandleVariableValue(actionProps: param.actionProps, value: param.variableValue) ?? ""
        value = value.cast(type: variable.type)

        // Trigger the onNext callback with the evaluated value.
        param.onNext(value)
    }
}
