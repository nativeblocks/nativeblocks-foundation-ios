import Foundation

extension String {
    func getVariableValue(_ key: String, _ value: String) -> String {
        return self.replacingOccurrences(of: "{\(key)}", with: value)
    }

    func hasJsonPath() -> Bool {
        return self.contains("$")
    }

    func hasOperator() -> Bool {
        return self.contains("+") || self.contains("-") || self.contains("*") || self.contains("/")
    }

    func operatorEvaluation() -> Float? {
        let tokens = self.split(separator: " ")
        guard tokens.count == 3,
            let operand1 = Float(tokens[0]),
            let operand2 = Float(tokens[2])
        else { return nil }

        let operatorSymbol = String(tokens[1])
        switch operatorSymbol {
        case "+": return operand1 + operand2
        case "-": return operand1 - operand2
        case "*": return operand1 * operand2
        case "/": return operand1 / operand2
        default: return nil
        }
    }

    func hasCondition() -> Bool {
        return self.contains("==") || self.contains("!=") || self.contains("||") || self.contains("&&") || self.contains("<")
            || self.contains("<=") || self.contains(">") || self.contains(">=")
    }

    func operatorCondition() -> Bool {
        let tokens = self.split(separator: " ").map { String($0) }
        let (expr, _) = parseCondition(tokens)
        return conditionEvaluation(expr)
    }
}

indirect enum ConditionExpression {
    case binaryOp(left: ConditionExpression, op: String, right: ConditionExpression)
    case boolLiteral(Bool)
    case intLiteral(Int)
    case stringLiteral(String)
}

func parseCondition(_ tokens: [String]) -> (ConditionExpression, [String]) {
    let (left, rest) = parsePrimaryCondition(tokens)
    if !rest.isEmpty, let op = rest.first, ["&&", "||", "==", "!=", ">", "<", ">=", "<="].contains(op) {
        let (right, rest2) = parseCondition(Array(rest.dropFirst()))
        return (.binaryOp(left: left, op: op, right: right), rest2)
    }
    return (left, rest)
}

func parsePrimaryCondition(_ tokens: [String]) -> (ConditionExpression, [String]) {
    guard let token = tokens.first else { return (.boolLiteral(false), []) }

    switch token {
    case "true":
        return (.boolLiteral(true), Array(tokens.dropFirst()))
    case "false":
        return (.boolLiteral(false), Array(tokens.dropFirst()))
    default:
        if let intValue = Int(token) {
            return (.intLiteral(intValue), Array(tokens.dropFirst()))
        } else {
            return (.stringLiteral(token), Array(tokens.dropFirst()))
        }
    }
}

func conditionEvaluation(_ expr: ConditionExpression) -> Bool {
    switch expr {
    case let .binaryOp(left, op, right):
        switch op {
        case "&&": return conditionEvaluation(left) && conditionEvaluation(right)
        case "||": return conditionEvaluation(left) || conditionEvaluation(right)
        case "==": return compareCondition(left, right) == .equal
        case "!=": return compareCondition(left, right) != .equal
        case ">=": return compareCondition(left, right) == .greater || compareCondition(left, right) == .equal
        case "<=": return compareCondition(left, right) == .less || compareCondition(left, right) == .equal
        case ">": return compareCondition(left, right) == .greater
        case "<": return compareCondition(left, right) == .less
        default: fatalError("Unknown operator: \(op)")
        }
    case let .boolLiteral(value):
        return value
    case .intLiteral, .stringLiteral:
        fatalError("Expected boolean, but got integer or string")
    }
}

enum ComparisonResult {
    case less, equal, greater
}

func compareCondition(_ left: ConditionExpression, _ right: ConditionExpression) -> ComparisonResult {
    switch (left, right) {
    case let (.intLiteral(leftValue), .intLiteral(rightValue)):
        if leftValue < rightValue { return .less }
        if leftValue > rightValue { return .greater }
        return .equal
    case let (.stringLiteral(leftValue), .stringLiteral(rightValue)):
        if leftValue < rightValue { return .less }
        if leftValue > rightValue { return .greater }
        return .equal
    case let (.boolLiteral(leftValue), .boolLiteral(rightValue)):
        if leftValue == rightValue { return .equal }
        return leftValue ? .greater : .less
    default:
        fatalError("Mismatched types in comparison")
    }
}

extension String {
    func removeWhitespaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
