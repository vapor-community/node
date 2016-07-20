import Foundation

extension String {
    /**
     Parses `key=value` pair data separated by `&`.

     - returns: String dictionary of parsed data
     */
    private func keyValuePairs() -> [String: String] {
        var data: [String: String] = [:]
        for pair in self.components(separatedBy: "&") {
            let tokens = pair
                .characters
                .split(separator: "=", maxSplits: 1)
                .map { String($0) }
            guard
                let name = tokens.first,
                let value = tokens.last
                else { continue }
            data[name] = value
        }

        return data
    }
}
