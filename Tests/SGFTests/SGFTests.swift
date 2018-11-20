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
        XCTAssert(str == inputString || str == "(;GM[1]FF[4])")
    }
}

final class SGFTests: XCTestCase {
    func testParseSGF() {
        let inputString = "(;FF[4]GN[\\:日本語\\]:a]CA[]\r\n(;B[bb])(;B[cc]))"
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(try! root.getValues(of: "FF")?.first, "4")
    }

    func testParseSGFNewLine() {
        let inputString = "(;FF[4];\nTB[ka:pa])"
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(try! root.getValues(of: "FF")?.first, "4")
    }

    func testParseSGF_issue13() {
        // KGSのSGFには:のエスケープ忘れがある。
        let inputString = try! String(contentsOfFile: "/Users/yuji/Projects/swift-SGF/Tests/SGFTests/#13.sgf")
        do {
            let collection = try parseSGF(inputString)
            let root = collection[0]
            XCTAssertEqual(try! root.getValues(of: "FF")?.first, "4")
        } catch {
            XCTAssert(true)
        }
    }

    func testParseSGF_issue17() {
        // SmartGoのSGFには;のあとに改行が来ることがある
        let inputString = try! String(contentsOfFile: "/Users/yuji/Projects/swift-SGF/Tests/SGFTests/#17.sgf")
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(try! root.getValues(of: "FF")?.first, "4")
    }

    static var allTests = [
        ("testParseSGF_issue13", testParseSGF_issue13),
        ("testParseSGF_issue17", testParseSGF_issue17),
        ("testParseSGFNewLine", testParseSGFNewLine),
        ("testParseSGF", testParseSGF),
    ]
}
