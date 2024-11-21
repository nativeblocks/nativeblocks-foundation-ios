import Nativeblocks
import NativeblocksCompiler
import SwiftUI

// @NativeAction(
//    name: "Native Change Variable",
//    keyType: "NATIVE_CHANGE_VARIABLE",
//    description: "Native Change Variable"
// )
public class NativeChangeVariable {
    public init() {}

    @NativeActionParameter()
    struct Parameter {
        @NativeActionProp(description: "key of the variable")
        var variableKey: String
        @NativeActionProp(description: "value of the variable")
        var variableValue: String
        @NativeActionEvent(then: .NEXT)
        var onNext: () -> Void
    }

    @NativeActionFunction()
    func onChangeBlock(param: Parameter) {
        param.onNext()
    }
}

class NativeChangeVariableAction: INativeAction {
    var action: NativeChangeVariable
    init(action: NativeChangeVariable) {
        self.action = action
    }

    func handle(actionProps: ActionProps) {
        let properties = actionProps.trigger?.properties ?? [:]
        let variableKeyProp = properties["variableKey"]?.value ?? ""
        let variableValueProp = properties["variableValue"]?.value ?? ""

        var value = variableValueProp
        if let variable = actionProps.variables?[variableKeyProp] {
            actionProps.variables?.forEach { variableItem in
                value = value.getVariableValue(variableItem.key, variableItem.value.value)
            }
            //value = value.getVariableValue("index", String(actionProps.listItemIndex ?? 0))
            value = value.evaluateMixConditionOperator(type: variable.type)
            var variableCopy = variable
            variableCopy.value = value
            actionProps.onVariableChange?(variableCopy)
        }
        let param = NativeChangeVariable.Parameter(
            variableKey: variableKeyProp,
            variableValue: variableValueProp,
            onNext: {
                if actionProps.trigger != nil {
                    actionProps.onHandleNextTrigger?(actionProps.trigger!)
                }
            })
        action.onChangeBlock(param: param)
    }
}
