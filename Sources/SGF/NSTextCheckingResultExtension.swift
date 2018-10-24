import Foundation

extension NSTextCheckingResult {
    func groups(testedString: String) -> [String] {
        return (0 ..< self.numberOfRanges).map {
            (testedString as NSString).substring(with: self.range(at: $0))
        }
    }
}