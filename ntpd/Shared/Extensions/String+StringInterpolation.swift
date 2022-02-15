import Foundation

extension String.StringInterpolation {

    static let formatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()

    mutating func appendInterpolation(date value: Date) {

        let dateString = Self.formatter.string(from: value)
        appendLiteral(dateString)
    }
}
