import XCTest
@testable import SGF

final class SGFUsage: XCTestCase {
    func testUsageParseSGF() {
        let inputString = "(;FF[4]GM[1];B[aa](;W[bb])(;W[cc]))"

        // You can get a collection, which is an array of SGFNode instances, by parseSGF.
        let collection = try! parseSGF(inputString)
        let root = collection[0]

        // To access a property, you can refer properties.
        // Every value of each property is an array of "SGFCValueType"
        if case let SGFCValueType.single(ffValue) = root.properties["FF"]![0] {
            XCTAssertEqual(ffValue, "4")
        } else {
            XCTFail()
        }
    }

    func testUsageSGFEncoder() {
        let inputString = "(;FF[4]GM[1])"
        let collection = try! parseSGF(inputString)

        // You can use SGFEncoder.encode(collection:) to stringify a collection, [SGFNode].
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
