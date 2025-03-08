import Nativeblocks
import NativeblocksCompiler

/// A class responsible for changing the variable within the Nativeblocks system.
///
/// The `NativeChangeVariable` class enables the modification of a value dynamically.
/// It supports variable substitution, conditional evaluation, and arithmetic operations for property values.
///
/// The `evaluateMixConditionOperator` function evaluates a value that may contain mixed conditions and operators
/// based on the variable type specified by `variableKey`. If the string contains conditions, it evaluates them and converts
/// the result to a boolean string if the variable type is "BOOLEAN". If the string contains operators, it evaluates the
/// expression and converts the result to the specified numeric type.
///
/// Supported types: "BOOLEAN", "INT", "DOUBLE", "LONG", "FLOAT", "STRING".
///
/// The evaluated variable value is returned as a string, or the original value if no conditions or operators are found.
///
/// ## Example 1 (for BOOLEAN type):
/// - variableValue: `"(4 / 2 != 0) && (true == true)"`
/// - Evaluated value: `"true"` (evaluates the condition and returns boolean as string)
///
/// ## Example 2 (for INT type):
/// - variableValue: `"(3+1)/2"`
/// - Evaluated value: `"2"` (evaluates the arithmetic expression and returns the result as an integer)
///
/// ## Example 3 (for STRING type):
/// - variableValue: `"\"test\" == \"test\""`
/// - Evaluated value: `"true"` (evaluates string equality and returns the result as string)
///
/// ## Example 4 (for FLOAT type):
/// - variableValue: `"2 * 2.5"`
/// - Evaluated value: `"5.0"` (evaluates multiplication and returns the result as float)
///
/// ## Example 5 (for Variable Substitution):
/// - variableKey: `"myVar"`
/// - variableValue: `"Hello, {myVar}!"`
/// - If `myVar` is `"World"`, the evaluated value will be `"Hello, World!"`.
///
@NativeAction(
    name: "Native Change Variable",
    keyType: "NATIVE_CHANGE_VARIABLE",
    description: "Native Change Variable"
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
        @NativeActionProp(description: "value of the variable", valuePicker: .TEXT_AREA_INPUT)
        var variableValue: String

        /// Callback triggered after the variable is updated.
        @NativeActionEvent(dataBinding: ["variableKey"], then: .NEXT)
        var onNext: (String) -> Void

        /// Additional properties for the action, such as variables and triggers.
        var actionProps: ActionProps
    }

    /// Function to handle the change of a variable.
    @NativeActionFunction()
    func onChangeBlock(param: Parameter) {
        // Retrieve data from the action properties.
        let data = param.actionProps.trigger?.data ?? [:]

        guard let variable = param.actionProps.variables?[data["variableKey"]?.value ?? ""] else { return }

        var value = actionHandleVariableValue(actionProps: param.actionProps, value: param.variableValue) ?? ""

        // Evaluate any conditions or arithmetic operations in the value.
        value = value.evaluateMixConditionOperator(type: variable.type)

        // Trigger the onNext callback with the evaluated value.
        param.onNext(value)
    }
}
