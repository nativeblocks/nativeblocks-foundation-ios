import Nativeblocks
import NativeblocksCompiler
import SwiftUI

//@NativeAction(
//    name: "Native Change Block Property",
//    keyType: "NATIVE_CHANGE_BLOCK_PROPERTY",
//    description: "Native Change Block Property"
//)
public class NativeChangeBlockProperty {
    public init() {

    }
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
    }

    @NativeActionFunction()
    func onChangeBlock(param: Parameter) {
        param.onNext()
    }
}

class NativeChangeBlockPropertyAction: INativeAction {

    var action: NativeChangeBlockProperty
    init(action: NativeChangeBlockProperty) {
        self.action = action
    }

    func handle(actionProps: ActionProps) {
        let properties = actionProps.trigger?.properties ?? [:]
        let blockKeyProp = properties["blockKey"]?.value ?? ""
        let propertyKeyProp = properties["propertyKey"]?.value ?? ""
        let propertyValueMobileProp = properties["propertyValueMobile"]?.value ?? ""
        let propertyValueTabletProp = properties["propertyValueTablet"]?.value ?? ""
        let propertyValueDesktopProp = properties["propertyValueDesktop"]?.value ?? ""

        var valueMobile = propertyValueMobileProp
        var valueTablet = propertyValueTabletProp
        var valueDesktop = propertyValueDesktopProp

        if let block = actionProps.blocks?[blockKeyProp] {
            var blockProperties = block.properties ?? [:]
            if var currentProperty = blockProperties[propertyKeyProp] {
                if !propertyValueMobileProp.isEmpty {
                    actionProps.variables?.forEach { variableItem in
                        valueMobile = valueMobile.getVariableValue(variableItem.key, variableItem.value.value)
                    }
                    valueMobile = valueMobile.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueMobile = valueMobile
                }
                if !propertyValueTabletProp.isEmpty {
                    actionProps.variables?.forEach { variableItem in
                        valueTablet = valueTablet.getVariableValue(variableItem.key, variableItem.value.value)
                    }
                    valueTablet = valueTablet.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueTablet = valueTablet
                }
                if !propertyValueDesktopProp.isEmpty {
                    actionProps.variables?.forEach { variableItem in
                        valueDesktop = valueDesktop.getVariableValue(variableItem.key, variableItem.value.value)
                    }
                    valueDesktop = valueDesktop.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueDesktop = valueDesktop
                }
                blockProperties[currentProperty.key] = currentProperty
            }

            var blockCopy = block
            blockCopy.properties = blockProperties

            actionProps.onChangeBlock?(blockCopy)
        }

        let param = NativeChangeBlockProperty.Parameter(
            blockKey: blockKeyProp,
            propertyKey: propertyKeyProp,
            propertyValueMobile: propertyValueMobileProp,
            propertyValueTablet: propertyValueTabletProp,
            propertyValueDesktop: propertyValueDesktopProp,
            onNext: {

                if actionProps.trigger != nil {
                    actionProps.onHandleNextTrigger?(actionProps.trigger!)
                }
            })
        action.onChangeBlock(param: param)
    }
}
