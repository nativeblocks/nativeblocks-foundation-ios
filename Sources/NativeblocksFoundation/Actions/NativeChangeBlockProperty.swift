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
    keyType: "NATIVE_CHANGE_BLOCK_PROPERTY",
    description: "Native Change Block Property",
    version: 2
)
public class NativeChangeBlockProperty {
    /// Initializes a new instance of `NativeChangeBlockProperty`.
    public init() {}

    /// The parameters required for the `NativeChangeBlockProperty` action.
    @NativeActionParameter()
    struct Parameter {
        /// The key of the block to modify.
        @NativeActionProp(description: "key of the block")
        var blockKey: String

        /// The key of the block's property to modify.
        @NativeActionProp(description: "key of the block's property")
        var propertyKey: String

        /// The new value for the block's mobile property.
        @NativeActionProp(description: "new value for the block's Mobile property", valuePicker: .SCRIPT_AREA_INPUT)
        var propertyValueMobile: String

        /// The new value for the block's tablet property.
        @NativeActionProp(description: "new value for the block's Tablet property", valuePicker: .SCRIPT_AREA_INPUT)
        var propertyValueTablet: String

        /// The new value for the block's desktop property.
        @NativeActionProp(description: "new value for the block's Desktop property", valuePicker: .SCRIPT_AREA_INPUT)
        var propertyValueDesktop: String

        /// A closure to execute after the property is changed.
        @NativeActionEvent(then: .NEXT)
        var onNext: () -> Void

        /// Additional action properties, such as variables and blocks.
        var actionProps: ActionProps
    }

    @NativeActionFunction()
    func onChangeBlock(param: Parameter) async {
        var valueMobile = param.propertyValueMobile
        var valueTablet = param.propertyValueTablet
        var valueDesktop = param.propertyValueDesktop

        if var block = param.actionProps.blocks?[param.blockKey] {
            if var currentProperty = block.properties?[param.propertyKey] {
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

                // Update the property in the block
                block.properties?[currentProperty.key] = currentProperty
            }

            // Notify the change
            param.actionProps.onChangeBlock?(block)
        }

        // Execute the next step
        param.onNext()
    }
}
