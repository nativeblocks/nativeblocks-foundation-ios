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
/// The `evaluateMixConditionOperator` function evaluates a property value that may contain mixed conditions and operators
/// based on the property type specified by `propertyKey`. If the string contains conditions, it evaluates them and converts
/// the result to a boolean string if the property type is "BOOLEAN". If the string contains operators, it evaluates the
/// expression and converts the result to the specified numeric type.
///
/// Supported types: "BOOLEAN", "INT", "DOUBLE", "LONG", "FLOAT".
///
/// The evaluated property value is returned as a string, or the original value if no conditions or operators are found.
///
/// ## Example 1 (for BOOLEAN type):
/// - propertyValue: `"(4 / 2 != 0) && (true == true)"`
/// - Evaluated value: `"true"` (evaluates the condition and returns boolean as string)
///
/// ## Example 2 (for INT type):
/// - propertyValue: `"(3+1)/2"`
/// - Evaluated value: `"2"` (evaluates the arithmetic expression and returns the result as an integer)
///
/// ## Example 3 (for STRING type):
/// - propertyValue: `"\"test\" == \"test\""`
/// - Evaluated value: `"true"` (evaluates string equality and returns the result as string)
///
/// ## Example 4 (for FLOAT type):
/// - propertyValue: `"2 * 2.5"`
/// - Evaluated value: `"5.0"` (evaluates multiplication and returns the result as float)
///
///
@NativeAction(
    name: "Native Change Block Property",
    keyType: "NATIVE_CHANGE_BLOCK_PROPERTY",
    description: "Native Change Block Property"
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
        @NativeActionProp(description: "new value for the block's Mobile property")
        var propertyValueMobile: String

        /// The new value for the block's tablet property.
        @NativeActionProp(description: "new value for the block's Tablet property")
        var propertyValueTablet: String

        /// The new value for the block's desktop property.
        @NativeActionProp(description: "new value for the block's Desktop property")
        var propertyValueDesktop: String

        /// A closure to execute after the property is changed.
        @NativeActionEvent(then: .NEXT)
        var onNext: () -> Void

        /// Additional action properties, such as variables and blocks.
        var actionProps: ActionProps?
    }


    @NativeActionFunction()
    func onChangeBlock(param: Parameter) {
        var valueMobile = param.propertyValueMobile
        var valueTablet = param.propertyValueTablet
        var valueDesktop = param.propertyValueDesktop

        if var block = param.actionProps?.blocks?[param.blockKey] {
            if var currentProperty = block.properties?[param.propertyKey] {
                // Update mobile value
                if !param.propertyValueMobile.isEmpty {
                    param.actionProps?.variables?.forEach { variableItem in
                        valueMobile = valueMobile.getVariableValue(key: variableItem.key, replacement: variableItem.value.value)
                    }
                    valueMobile = valueMobile.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueMobile = valueMobile
                }

                // Update tablet value
                if !param.propertyValueTablet.isEmpty {
                    param.actionProps?.variables?.forEach { variableItem in
                        valueTablet = valueTablet.getVariableValue(key: variableItem.key, replacement: variableItem.value.value)
                    }
                    valueTablet = valueTablet.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueTablet = valueTablet
                }

                // Update desktop value
                if !param.propertyValueDesktop.isEmpty {
                    param.actionProps?.variables?.forEach { variableItem in
                        valueDesktop = valueDesktop.getVariableValue(key: variableItem.key, replacement: variableItem.value.value)
                    }
                    valueDesktop = valueDesktop.evaluateMixConditionOperator(type: currentProperty.type)
                    currentProperty.valueDesktop = valueDesktop
                }

                // Update the property in the block
                block.properties?[currentProperty.key] = currentProperty
            }

            // Notify the change
            param.actionProps?.onChangeBlock?(block)
        }

        // Execute the next step
        param.onNext()
    }
}
