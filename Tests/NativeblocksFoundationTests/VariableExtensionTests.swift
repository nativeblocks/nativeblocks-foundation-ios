import XCTest

@testable import NativeblocksFoundation

final class VariableExtensionTests: XCTestCase {
    func testEvaluateConditionNumber() throws {
        let condition1 = "1<=2"
        XCTAssertEqual(condition1.evaluateCondition(), true)
        let condition2 = "1==1"
        XCTAssertEqual(condition2.evaluateCondition(), true)
        let condition3 = "2>1"
        XCTAssertEqual(condition3.evaluateCondition(), true)
        let condition4 = "41!=32"
        XCTAssertEqual(condition4.evaluateCondition(), true)
    }

    func testEvaluateConditionString() throws {
        let condition1 = "\"test\"==\"test\""
        XCTAssertEqual(condition1.evaluateCondition(), true)
        let condition2 = "\"test\"!=\"test2\""
        XCTAssertEqual(condition2.evaluateCondition(), true)
        let condition3 = "test!=test2"
        XCTAssertEqual(condition3.evaluateCondition(), false)
    }

    func testEvaluateConditionNumberFail() throws {
        let condition1 = "\"test\"=="
        XCTAssertEqual(condition1.evaluateCondition(), false)
    }

    func testEvaluateOperatorNumber() throws {
        let condition1 = "1+2-2"
        XCTAssertEqual(condition1.evaluateOperator(), 1)
        let condition2 = "2*2*2"
        XCTAssertEqual(condition2.evaluateOperator(), 8)
        let condition3 = "1-2"
        XCTAssertEqual(condition3.evaluateOperator(), -1)
        let condition4 = "2/2"
        XCTAssertEqual(condition4.evaluateOperator(), 1)
    }

    func testEvaluateOperatorNumberFail() throws {
        let condition1 = "\"test\"=="
        XCTAssertEqual(condition1.evaluateOperator(), nil)
    }

    func testEvaluateOperatorNumberMix() throws {
        XCTAssertEqual("(4 / 2 != 0) && (true == true)".evaluateCondition(), true)
    }

    func testEvaluateMixConditionOperatorBoolean() throws {
        XCTAssertEqual("(4 / 2 != 0) && (true == true)".evaluateMixConditionOperator(type: "BOOLEAN"), "true")
        XCTAssertEqual("3+1".evaluateMixConditionOperator(type: "BOOLEAN"), "3+1")
    }

    func testEvaluateMixConditionOperatorNumber() throws {
        XCTAssertEqual("(4 / 2 != 0) && (true == true)".evaluateMixConditionOperator(type: "INT"), "(4 / 2 != 0) && (true == true)")
        XCTAssertEqual("3+1".evaluateMixConditionOperator(type: "INT"), "4.0")
    }

    func testEvaluateMixConditionOperatorString() throws {
        XCTAssertEqual("(4 / 2 != 0) && (true == true)".evaluateMixConditionOperator(type: "STRING"), "(4 / 2 != 0) && (true == true)")
        XCTAssertEqual("3+1".evaluateMixConditionOperator(type: "STRING"), "3+1")
    }
}
