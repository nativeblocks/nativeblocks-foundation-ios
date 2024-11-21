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

    func evaluateOperator() -> Double? {
        do {
            let sanitizedExpression = self.trimmingCharacters(in: .whitespacesAndNewlines)
            let exp = try NSExpression(format: sanitizedExpression)
            let result = try exp.expressionValue(with: nil, context: nil) as? Double
            return result
        } catch {
            return nil
        }
    }

    func hasCondition() -> Bool {
        return self.contains("==") || self.contains("!=") || self.contains("||") || self.contains("&&") || self.contains("<")
            || self.contains("<=") || self.contains(">") || self.contains(">=")
    }

    //    func evaluateCondition() -> Bool {
    //        let predicateWrapper = NSPredicateWrapper(expression: self)
    //        return predicateWrapper.evaluate(with: nil)
    //    }
    func evaluateCondition() -> Bool {
        let sanitizedExpression =
            self
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if let predicate = try? NSPredicate(format: sanitizedExpression) {
            if let result = try? predicate.evaluate(with: nil) {
                return result
            } else {
                print("Failed to evaluate condition: \(sanitizedExpression)")
                return false
            }
        } else {
            print("Failed to evaluate condition: \(sanitizedExpression)")
            return false
        }
    }
}
