import SwiftUI
import XCTest

@testable import NativeblocksFoundation

final class TypeConverterTests: XCTestCase {
    func testColor() throws {
        let converter = ColorNativeType()
        XCTAssertEqual(converter.toString(Color(hex: "#FFFF0000")), "#FFFF0000")
        XCTAssertEqual(converter.fromString("#FFFF0000"), Color(hex: "#FFFF0000"))

        XCTAssertEqual(converter.toString(Color.white), "#FFFFFFFF")
        XCTAssertEqual(converter.fromString("#FFFFFFFF"), Color.white)
    }

    func testFontDesign() throws {
        let converter = FontDesignNativeType()
        XCTAssertEqual(converter.toString(.serif), "serif")
        XCTAssertEqual(converter.fromString("serif"), .serif)
    }

    func testFontWeight() throws {
        let converter = FontWeightNativeType()
        XCTAssertEqual(converter.toString(.ultraLight), "ultraLight")
        XCTAssertEqual(converter.fromString("ultraLight"), .ultraLight)
    }

    func testHorizontalAlignment() throws {
        let converter = HorizontalAlignmentNativeType()
        XCTAssertEqual(converter.toString(.center), "center")
        XCTAssertEqual(converter.fromString("center"), .center)
    }

    func testLayoutDirection() throws {
        let converter = LayoutDirectionNativeType()
        XCTAssertEqual(converter.toString(.leftToRight), "LTR")
        XCTAssertEqual(converter.fromString("LTR"), .leftToRight)
    }

    func testTextAlignment() throws {
        let converter = TextAlignmentNativeType()
        XCTAssertEqual(converter.toString(.leading), "leading")
        XCTAssertEqual(converter.fromString("leading"), .leading)
    }

    func testScrollable() throws {
        let converter = ScrollableNativeType()
        XCTAssertEqual(converter.toString(.horizontal), "horizontal")
        XCTAssertEqual(converter.fromString("horizontal"), .horizontal)

        XCTAssertEqual(converter.toString([.vertical, .horizontal]), "both")
        XCTAssertEqual(converter.fromString("both"), [.vertical, .horizontal])
    }

    func testVerticalAlignment() throws {
        let converter = VerticalAlignmentNativeType()
        XCTAssertEqual(converter.toString(.firstTextBaseline), "firstTextBaseline")
        XCTAssertEqual(converter.fromString("firstTextBaseline"), .firstTextBaseline)
    }
}
