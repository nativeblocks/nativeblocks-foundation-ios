import Nativeblocks
import NativeblocksCompiler
import SwiftUI

/// A class responsible for changing the properties of a block within the Nativeblocks system.
/// This action allows modification of a block's properties across different device types (Mobile, Tablet, and Desktop).
///
/// Changes the specified property of a block.
///
/// This function updates the mobile, tablet, and desktop values of a block's property.
/// It supports variable substitution and conditional evaluation for the property values.
///
/// Property Value Supported Formats:
///   - `{var:variable-key}`: Replaces with the value of the variable.
///   - `{index}`: Replaces with the list item index.
///   - `#SCRIPT 2 + 2 #ENDSCRIPT`: The string with evaluated JavaScript code replacing the script tags.
///
@NativeAction(
    name: "Native Change Block Property",
    keyType: "nativeblocks/change_block_property",
    description: "Native Change Block Property",
    version: 1,
    versionName: "1.0.0"
)
public class NativeChangeBlockProperty {

    /// Parameters for the action.
    @NativeActionParameter
    struct Parameter {
        var actionProps: ActionProps

        @NativeActionProp(description: "key of the block")
        var blockKey: String

        @NativeActionProp(description: "key of the block's property")
        var propertyKey: String

        @NativeActionProp(
            description: "new value for the block's Mobile property",
            valuePicker: .SCRIPT_AREA_INPUT
        )
        var propertyValueMobile: String

        @NativeActionProp(
            description: "new value for the block's Tablet property",
            valuePicker: .SCRIPT_AREA_INPUT
        )
        var propertyValueTablet: String

        @NativeActionProp(
            description: "new value for the block's Desktop property",
            valuePicker: .SCRIPT_AREA_INPUT
        )
        var propertyValueDesktop: String

        @NativeActionEvent(then: .NEXT)
        var onNext: () -> Void
    }

    @NativeActionFunction
    @MainActor
    func onChangeBlock(param: Parameter) async {
        var valueMobile = param.propertyValueMobile
        var valueTablet = param.propertyValueTablet
        var valueDesktop = param.propertyValueDesktop

        if let block = param.actionProps.onFindBlock(param.blockKey) {
            var blockProperties = block.properties ?? [:]

            if var currentProperty = blockProperties[param.propertyKey] {
                // Update mobile value
                if !param.propertyValueMobile.isEmpty {
                    valueMobile = actionHandleVariableValue(actionProps: param.actionProps, value: valueMobile) ?? ""
                    valueMobile = valueMobile.cast(type: currentProperty.type)
                    currentProperty.valueMobile = valueMobile
                }

                // Update tablet value
                if !param.propertyValueTablet.isEmpty {
                    valueTablet = actionHandleVariableValue(actionProps: param.actionProps, value: valueTablet) ?? ""
                    valueTablet = valueTablet.cast(type: currentProperty.type)
                    currentProperty.valueTablet = valueTablet
                }

                // Update desktop value
                if !param.propertyValueDesktop.isEmpty {
                    valueDesktop = actionHandleVariableValue(actionProps: param.actionProps, value: valueDesktop) ?? ""
                    valueDesktop = valueDesktop.cast(type: currentProperty.type)
                    currentProperty.valueDesktop = valueDesktop
                }

                blockProperties[currentProperty.key] = currentProperty
            }

            let updatedBlock = block.copy(properties: blockProperties)
            param.actionProps.onChangeBlock(updatedBlock)
        }

        param.onNext()
    }
}
