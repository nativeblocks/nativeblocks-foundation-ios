import Foundation
import Nativeblocks

///
///Provides foundational types, actions, and blocks to the Nativeblocks framework.
///This object serves as a centralized provider for registering types, actions, and blocks
///specific to the foundation module.
///
public class FoundationProvider {
    ///
    /// Initializes and registers foundational types, actions, and blocks with the Nativeblocks framework.
    ///
    /// This function performs the following:
    /// - Registers foundational types by invoking `FoundationTypeProvider.provideTypes()`.
    /// - Registers foundational blocks by invoking `FoundationBlockProvider.provideBlocks()`.
    ///
    /// Call this method to ensure that the foundation module's functionalities are properly
    /// integrated into the Nativeblocks framework.
    ///
    public static func provide(name: String = "default") {
        FoundationBlockProvider.provideBlocks(name: name)
        FoundationTypeProvider.provideTypes(name: name)
    }
}
