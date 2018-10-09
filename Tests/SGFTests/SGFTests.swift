import XCTest
@testable import SGF

final class SGFUsage: XCTestCase {
    func testUsageParseSGF() {
        let inputString = "(;FF[4]GM[1];B[aa](;W[bb])(;W[cc]))"
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        if case let SGFCValueType.single(ffValue) = root.properties["FF"]![0] {
            XCTAssertEqual(ffValue, "4")
        } else {
            XCTFail()
        }
    }

    func testUsageSGFEncoder() {
        let inputString = "(;FF[4]GM[1])"
        let collection = try! parseSGF(inputString)
        let str = SGFEncoder.encode(collection: collection)
        XCTAssertEqual(str, inputString)
    }
}

final class SGFTests: XCTestCase {
    func testParseSGF() {
        let inputString = "(;FF[4]GN[\\:日本語\\]:a]CA[]\n(;B[bb])(;B[cc]))"
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        if case let SGFCValueType.single(ffValue) = root.properties["FF"]![0] {
            XCTAssertEqual(ffValue, "4")
        } else {
            XCTFail()
        }
    }
}
