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
        XCTAssertEqual(try! root.getValues(of: "FF")?.first, "4")
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
        let inputString = "(;FF[4]GN[\\:日本語\\]:a]CA[]\r\n(;B[bb])(;B[cc]))"
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(try! root.getValues(of: "FF")?.first, "4")
    }
}
