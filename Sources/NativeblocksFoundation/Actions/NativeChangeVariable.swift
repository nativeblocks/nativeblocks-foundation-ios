import Nativeblocks
import NativeblocksCompiler

@NativeAction(
    name: "Native Change Variable",
    keyType: "NATIVE_CHANGE_VARIABLE",
    description: "Native Change Variable"
)
public class NativeChangeVariable {
    public init() {}

    @NativeActionParameter()
    struct Parameter {
        @NativeActionData(description: "key of the variable")
        var variableKey: String
        @NativeActionProp(description: "value of the variable", valuePicker: .TEXT_AREA_INPUT)
        var variableValue: String
        @NativeActionEvent(dataBinding: ["variableKey"], then: .NEXT)
        var onNext: (String) -> Void
        var actionProps: ActionProps?
    }

    @NativeActionFunction()
    func onChangeBlock(param: Parameter) {
        let data = param.actionProps?.trigger?.data ?? [:]
        let variableKeyData = param.actionProps?.variables?[data["variableKey"]?.value ?? ""]

        var value = param.variableValue
        guard let variable = variableKeyData else { return }

        param.actionProps?.variables?.forEach { variableItem in
            value = value.getVariableValue(key: variableItem.key, replacement: variableItem.value.value)
        }
        value = value.toActionDataStringValue(variables: param.actionProps?.variables, index: param.actionProps?.listItemIndex)
        value = value.evaluateMixConditionOperator(type: variable.type)

        param.onNext(value)
    }
}
