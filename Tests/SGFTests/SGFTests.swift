import XCTest
@testable import SGF

final class swift_SGFTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let inputString = "(;FF[4]GN[\\:日本語いけますか？\\]:a]CA[]\n(;B[bb])(;B[cc]))"
        let tree = try! parseSGF(inputString)
        XCTAssertNotNil(tree)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
