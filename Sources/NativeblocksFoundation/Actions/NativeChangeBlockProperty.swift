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
        @NativeActionProp(description: "new value for the block's property")
        var propertyValue: String
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
        let propertyValueProp = properties["propertyValue"]?.value ?? ""

        if let block = actionProps.blocks?[blockKeyProp] {
            var blockProperties = block.properties ?? [:]
            if var currentProperty = blockProperties[propertyKeyProp] {
                currentProperty.valueMobile = propertyValueProp
                blockProperties[currentProperty.key] = currentProperty
            }

            var blockCopy = block
            blockCopy.properties = blockProperties

            actionProps.onChangeBlock?(blockCopy)
        }

        let param = NativeChangeBlockProperty.Parameter(
            blockKey: blockKeyProp,
            propertyKey: propertyKeyProp,
            propertyValue: propertyValueProp,
            onNext: {

                if actionProps.trigger != nil {
                    actionProps.onHandleNextTrigger?(actionProps.trigger!)
                }
            })
        action.onChangeBlock(param: param)
    }
}
