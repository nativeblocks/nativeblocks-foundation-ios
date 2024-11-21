import ExceptionCatcher
import Foundation

extension String {
    func getVariableValue(_ key: String, _ value: String) -> String {
        return self.replacingOccurrences(of: "{\(key)}", with: value)
    }

    func hasOperator() -> Bool {
        return self.contains("+") || self.contains("-") || self.contains("*") || self.contains("/")
    }

    func evaluateOperator() -> Double? {
        var caughtException: NSException?

        let result: Double? =
            ExceptionCatcher.try(
                {
                    let sanitizedExpression = self.trimmingCharacters(in: .whitespacesAndNewlines)
                    let exp = NSExpression(format: sanitizedExpression)
                    return exp.expressionValue(with: nil, context: nil) as? Double
                }, exception: &caughtException) as? Double

        if let exception = caughtException {
            return nil
        }

        return result
    }

    func hasCondition() -> Bool {
        return self.contains("==") || self.contains("!=") || self.contains("||") || self.contains("&&") || self.contains("<")
            || self.contains("<=") || self.contains(">") || self.contains(">=")
    }

    func evaluateCondition() -> Bool {
        var caughtException: NSException? = nil

        let result: Bool? =
            ExceptionCatcher.try(
                {
                    let sanitizedExpression = self.trimmingCharacters(in: .whitespacesAndNewlines)
                    let predicate = NSPredicate(format: sanitizedExpression)
                    return predicate.evaluate(with: nil)
                }, exception: &caughtException) as? Bool

        if let exception = caughtException {
            return false
        }

        return result ?? false
    }

    func evaluateMixConditionOperator(type: String) -> String {
        var value = self

        if value.hasCondition() {
            value = {
                switch type.uppercased() {
                case "BOOLEAN":
                    return String(value.evaluateCondition())
                default:
                    return value
                }
            }()
        } else if value.hasOperator() {
            value = {
                switch type.uppercased() {
                case "INT":
                    return String(value.evaluateOperator()?.rounded() ?? 0)
                case "DOUBLE":
                    return String(value.evaluateOperator() ?? 0.0)
                case "LONG":
                    return String(Int(value.evaluateOperator() ?? 0.0))
                case "FLOAT":
                    return String(value.evaluateOperator() ?? 0.0)
                default:
                    return value
                }
            }()
        }
        return value
    }

}
