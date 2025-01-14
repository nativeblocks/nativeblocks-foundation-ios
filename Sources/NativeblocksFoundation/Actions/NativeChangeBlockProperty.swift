import Nativeblocks
import NativeblocksCompiler
import SwiftUI

@NativeAction(
    name: "Native Change Block Property",
    keyType: "NATIVE_CHANGE_BLOCK_PROPERTY",
    description: "Native Change Block Property"
)
public class NativeChangeBlockProperty {
    public init() {}

    @NativeActionParameter()
    struct Parameter {
        @NativeActionProp(description: "key of the block")
        var blockKey: String
        @NativeActionProp(description: "key of the block's property")
        var propertyKey: String
        @NativeActionProp(description: "new value for the block's Mobile property")
        var propertyValueMobile: String
        @NativeActionProp(description: "new value for the block's Tablet property")
        var propertyValueTablet: String
        @NativeActionProp(description: "new value for the block's Desktop property")
        var propertyValueDesktop: String
        @NativeActionEvent(then: .NEXT)
        var onNext: () -> Void
        var actionProps: ActionProps?
    }

    @NativeActionFunction()
    func onChangeBlock(param: Parameter) {
        var valueMobile = param.propertyValueMobile
        var valueTablet = param.propertyValueTablet
        var valueDesktop = param.propertyValueDesktop

        if var block = param.actionProps?.blocks?[param.blockKey] {
            if var currentProperty = block.properties?[param.propertyKey] {
                if !param.propertyValueMobile.isEmpty {
                    param.actionProps?.variables?.forEach { variableItem in
                        valueMobile = valueMobile.getVariableValue(key: variableItem.key, replacement: variableItem.value.value)
                    }
                    valueMobile = valueMobile.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueMobile = valueMobile
                }
                if !param.propertyValueTablet.isEmpty {
                    param.actionProps?.variables?.forEach { variableItem in
                        valueTablet = valueTablet.getVariableValue(key: variableItem.key, replacement: variableItem.value.value)
                    }
                    valueTablet = valueTablet.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueTablet = valueTablet
                }
                if !param.propertyValueDesktop.isEmpty {
                    param.actionProps?.variables?.forEach { variableItem in
                        valueDesktop = valueDesktop.getVariableValue(key: variableItem.key, replacement: variableItem.value.value)
                    }
                    valueDesktop = valueDesktop.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueDesktop = valueDesktop
                }
                block.properties?[currentProperty.key] = currentProperty
            }

            param.actionProps?.onChangeBlock?(block)
        }

        param.onNext()
    }
}
