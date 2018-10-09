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

    func testExample2() {
        let inputString = "(;RU[Japanese])"
        let tree = try! parseSGF(inputString)
        print(tree.description)
        XCTAssertNotNil(tree)
    }

    func testExample3() {
        let inputString = "(;FF[4]GM[1]CA[utf-8]AP[耳赤:119]US[mimiaka1846]SZ[19]RU[Japanese]KM[6.5]DT[2018-06-11]EV[test]GN[test];B[pd];W[dd];B[pp];W[dq];B[do];W[co];B[dp];W[cp];B[eq];W[cn];B[dn])"
        let tree = try! parseSGF(inputString)
        XCTAssertNotNil(tree)
    }
}
