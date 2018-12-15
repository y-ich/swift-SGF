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
        XCTAssertEqual(root["FF"]?.first, "4")
    }

    func testUsageSGFEncoder() {
        let inputString = "(;FF[4]GM[1]\n;B[aa])"
        let collection = try! parseSGF(inputString)

        // You can use SGFEncoder.encode(collection:) to stringify a collection, [SGFNode].
        let str = SGFEncoder.encode(collection: collection)
        XCTAssert(str == inputString || str == "(;GM[1]FF[4]\n;B[aa])")
    }
}

final class SGFTests: XCTestCase {
    func testParseSGF() {
        let inputString = "(;FF[4]GN[\\:日本語\\]:a]CA[]\r\n(;B[bb])(;B[cc]))"
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(root["FF"]?.first, "4")
    }

    func testParseSGFNewLine() {
        //let inputString = "(;\nGM[1]\nCoPyright[\n Copyright (c) PANDANET Inc. 2018\n  Permission to reproduce this game is given, provided proper credit is given.\n  No warrantee, implied or explicit, is understood.\n  Use of this game is an understanding and agreement of this notice.\n])"
        let inputString = "(;\nGM[1]\r\nCoPyright[\r\n  Copyright (c) PANDANET Inc. 2018\r\n  Permission to reproduce this game is given, provided proper credit is given.\r\n  No warrantee, implied or explicit, is understood.\r\n  Use of this game is an understanding and agreement of this notice.\r\n])"
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(root["GM"]?.first, "1")
    }

    func testParseSGF_issue10() {
        // Pandanet with CRLF
        do {
            let inputString = try String(contentsOfFile: "/Users/yuji/Projects/swift-SGF/Tests/SGFTests/#10.sgf")
            let collection = try parseSGF(inputString)
            let root = collection[0]
            XCTAssertEqual(root["GM"]?.first, "1")
        } catch {
            print("exception", error)
            XCTAssert(false)
        }
    }

    func testParseSGF_issue10_1() {
        // Pandanet with LF
        do {
            let inputString = try String(contentsOfFile: "/Users/yuji/Projects/swift-SGF/Tests/SGFTests/#10_1.sgf")
            let collection = try parseSGF(inputString)
            let root = collection[0]
            debugPrint(root)
            XCTAssertEqual(root["GM"]?.first, "1")
        } catch let error {
            print("exception", error)
            XCTAssert(false)
        }
    }

    func testParseSGF_issue13() {
        // KGSのSGFには:のエスケープ忘れがある。
        let inputString = try! String(contentsOfFile: "/Users/yuji/Projects/swift-SGF/Tests/SGFTests/#13.sgf")
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(root["FF"]?.first, "4")
    }

    func testParseSGF_issue17() {
        // SmartGoのSGFには;のあとに改行が来ることがある
        let inputString = try! String(contentsOfFile: "/Users/yuji/Projects/swift-SGF/Tests/SGFTests/#17.sgf")
        let collection = try! parseSGF(inputString)
        let root = collection[0]
        XCTAssertEqual(root["FF"]?.first, "4")
    }

    /*
    static var allTests = [
        ("testParseSGF", testParseSGF),
        ("testParseSGFNewLine", testParseSGFNewLine),
        ("testParseSGF_issue10", testParseSGF_issue10),
        ("testParseSGF_issue13", testParseSGF_issue13),
        ("testParseSGF_issue17", testParseSGF_issue17),
    ]
    */
}

final class SGFCursorTests: XCTestCase {
    func testToSgf() {
        let cursor = SGFCursor()
        XCTAssertEqual(cursor.toSgf(), "(;KM[7.5]FF[4]GM[1]SZ[19])")
    }
}