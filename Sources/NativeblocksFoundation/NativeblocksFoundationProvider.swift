import Foundation
import Nativeblocks

///
///Provides foundational types, actions, and blocks to the Nativeblocks framework.
///This object serves as a centralized provider for registering types, actions, and blocks
///specific to the foundation module.
///
public class NativeblocksFoundationProvider {
    ///
    /// Initializes and registers foundational types, actions, and blocks with the Nativeblocks framework.
    ///
    /// This function performs the following:
    /// - Registers foundational types by invoking `NativeblocksFoundationTypeProvider.provideTypes()`.
    /// - Registers actions, including:
    ///   - [NativeChangeVariable]: An action for modifying variables with dynamic evaluation.
    ///   - [NativeChangeBlockProperty]: An action for changing block properties.
    /// - Registers foundational blocks by invoking `NativeblocksFoundationBlockProvider.provideBlocks()`.
    ///
    /// Call this method to ensure that the foundation module's functionalities are properly
    /// integrated into the Nativeblocks framework.
    ///
    public static func provide(name: String = "default") {
        NativeblocksFoundationActionProvider.provideActions(name: name)
        NativeblocksFoundationBlockProvider.provideBlocks(name: name)
        NativeblocksFoundationTypeProvider.provideTypes(name: name)
    }
}
