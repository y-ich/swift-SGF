// This file is automatically generated by Citron version 2.0.
//
// The parser class defined below conforms to the CitronParser protocol
// defined in CitronParser.swift. 
// 
// The authors of Citron disclaim copyright to the source code in this file.

// Parser class

class SGFParser: CitronParser {

    // Types

    typealias CitronSymbolNumber = UInt8
    typealias CitronStateNumber = UInt8
    typealias CitronRuleNumber = UInt8

    enum CitronTokenCode: CitronSymbolNumber {
      case OPEN_PARENTHESIS               =   1
      case CLOSE_PARENTHESIS              =   2
      case SEMICOLUMN                     =   3
      case PROP_INDENT                    =   4
      case SINGLE                         =   5
      case COMPOSE                        =   6
    }

    enum CitronNonTerminalCode: CitronSymbolNumber {
      case c_value_type                   =   7
      case prop_value                     =   8
      case prop_value_list                =   9
      case property                       =  10
      case property_list                  =  11
      case node                           =  12
      case sequence                       =  13
      case gametree                       =  14
      case gametree_list                  =  15
      case collection                     =  16
      case output                         =  17
    }

    enum CitronSymbolCode : RawRepresentable, Equatable {
        case token(CitronTokenCode)
        case nonterminal(CitronNonTerminalCode)
        case endOfInput

        init(_ token: CitronTokenCode) { self = .token(token) }
        init(_ nonterminal: CitronNonTerminalCode) { self = .nonterminal(nonterminal) }
        init(rawValue: CitronSymbolNumber) {
            if (rawValue == 0) {
                self = .endOfInput
            } else if (rawValue < 7) {
                self = .token(CitronTokenCode(rawValue: rawValue)!)
            } else if (rawValue < 18) {
                self = .nonterminal(CitronNonTerminalCode(rawValue: rawValue)!)
            } else {
                fatalError()
            }
        }

        typealias RawValue = CitronSymbolNumber
        var rawValue: CitronSymbolNumber {
            switch (self) {
            case .token(let t): return t.rawValue
            case .nonterminal(let nt): return nt.rawValue
            case .endOfInput: return 0
            }
        }
    }

    typealias CitronToken = SGFToken

    enum CitronSymbol {
        case yyBaseOfStack
        case yy0(CitronToken)
        case yy3(SGFCValueType)
        case yy4((String, [SGFCValueType]))
        case yy11([(String, [SGFCValueType])])
        case yy12([SGFNode])
        case yy15(SGFNode)
        case yy27([SGFCValueType])

        func typeErasedContent() -> Any {
            switch (self) {
            case .yyBaseOfStack: fatalError()
            case .yy0(let value): return value as Any
            case .yy3(let value): return value as Any
            case .yy4(let value): return value as Any
            case .yy11(let value): return value as Any
            case .yy12(let value): return value as Any
            case .yy15(let value): return value as Any
            case .yy27(let value): return value as Any
            }
        }
    }

    typealias CitronResult = [SGFNode]

    // Counts

    let yyNumberOfSymbols: Int = 18
    let yyNumberOfStates: Int = 12

    // Action tables

    let yyLookaheadAction: [(CitronSymbolNumber, CitronParsingAction)] = [
/*   0 */  (14, .SH( 9)), ( 4, .SH( 2)), (16, .SH(11)), (17, .ACCEPT),   ( 5, .SR(16)),
/*   5 */  ( 6, .SR(17)), ( 8, .SH( 1)), ( 9, .RD(15)), ( 8, .SH( 1)), ( 9, .RD(13)),
/*  10 */  ( 1, .SH( 8)), ( 2, .SR( 3)), ( 1, .SH( 8)), (10, .SH( 4)), (11, .RD(12)),
/*  15 */  (14, .SH( 7)), (15, .SH(10)), (10, .SH( 4)), (11, .RD(10)), ( 3, .SH( 5)),
/*  20 */  (12, .SH( 6)), (13, .RD( 8)), ( 2, .SR( 4)), ( 0, .RD( 0)), (14, .SH( 7)),
/*  25 */  (15, .RD( 6)), (12, .SH( 6)), (13, .SH( 3)), (18, .RD( 2)), (14, .SH( 9)),
/*  30 */  (18, .RD( 2)), (16, .RD( 2)),
    ]

    let yyShiftUseDefault: Int = 32
    let yyShiftOffsetMin: Int = -3
    let yyShiftOffsetMax: Int = 23
    let yyShiftOffset: [Int] = [
        /*     0 */    11,   -1,   -1,    9,   -3,   -3,   16,   11,   16,   11,
        /*    10 */    20,   23,
    ]

    let yyReduceUseDefault: Int = -15
    let yyReduceOffsetMin: Int =   -14
    let yyReduceOffsetMax: Int =   15
    let yyReduceOffset: [Int] = [
        /*     0 */   -14,   -2,    0,    1,    3,    7,    8,   10,   14,   15,
    ]

    let yyDefaultAction: [CitronParsingAction] = [
  /*     0 */  .ERROR , .RD(14), .ERROR , .ERROR , .RD(11),
  /*     5 */  .RD( 9), .RD( 7), .RD( 5), .ERROR , .RD( 1),
  /*    10 */  .ERROR , .ERROR ,
    ]

    // Fallback

    let yyHasFallback: Bool = false
    let yyFallback: [CitronSymbolNumber] = []

    // Wildcard

    let yyWildcard: CitronSymbolNumber? = nil

    // Rules

    let yyRuleInfo: [(lhs: CitronSymbolNumber, nrhs: UInt)] = [
        (lhs: 17, nrhs: 1),
        (lhs: 16, nrhs: 1),
        (lhs: 16, nrhs: 2),
        (lhs: 14, nrhs: 3),
        (lhs: 14, nrhs: 4),
        (lhs: 15, nrhs: 1),
        (lhs: 15, nrhs: 2),
        (lhs: 13, nrhs: 1),
        (lhs: 13, nrhs: 2),
        (lhs: 12, nrhs: 1),
        (lhs: 12, nrhs: 2),
        (lhs: 11, nrhs: 1),
        (lhs: 11, nrhs: 2),
        (lhs: 10, nrhs: 2),
        (lhs: 9, nrhs: 1),
        (lhs: 9, nrhs: 2),
        (lhs: 8, nrhs: 1),
        (lhs: 8, nrhs: 1),
    ]

    // Stack

    var yyStack: [(stateOrRule: CitronStateOrRule , symbolCode: CitronSymbolNumber, symbol: CitronSymbol)]  = [
        (stateOrRule: .state(0), symbolCode: 0, symbol: .yyBaseOfStack)
    ]
    var maxStackSize: Int? = nil
    var maxAttainedStackSize: Int = 0

    // Tracing

    var isTracingEnabled: Bool = false
    let yySymbolName: [String] = [
    /*  0 */ "$",
    /*  1 */ "OPEN_PARENTHESIS",
    /*  2 */ "CLOSE_PARENTHESIS",
    /*  3 */ "SEMICOLUMN",
    /*  4 */ "PROP_INDENT",
    /*  5 */ "SINGLE",
    /*  6 */ "COMPOSE",
    /*  7 */ "c_value_type",
    /*  8 */ "prop_value",
    /*  9 */ "prop_value_list",
    /* 10 */ "property",
    /* 11 */ "property_list",
    /* 12 */ "node",
    /* 13 */ "sequence",
    /* 14 */ "gametree",
    /* 15 */ "gametree_list",
    /* 16 */ "collection",
    /* 17 */ "output",
    ]
    let yyRuleText: [String] = [
        /*   0 */ "output ::= collection(a)",
        /*   1 */ "collection ::= gametree(a)",
        /*   2 */ "collection ::= gametree(a) collection(b)",
        /*   3 */ "gametree ::= OPEN_PARENTHESIS sequence(a) CLOSE_PARENTHESIS",
        /*   4 */ "gametree ::= OPEN_PARENTHESIS sequence(a) gametree_list(b) CLOSE_PARENTHESIS",
        /*   5 */ "gametree_list ::= gametree(a)",
        /*   6 */ "gametree_list ::= gametree(a) gametree_list(b)",
        /*   7 */ "sequence ::= node(a)",
        /*   8 */ "sequence ::= node(a) sequence(b)",
        /*   9 */ "node ::= SEMICOLUMN",
        /*  10 */ "node ::= SEMICOLUMN property_list(a)",
        /*  11 */ "property_list ::= property(a)",
        /*  12 */ "property_list ::= property(a) property_list(b)",
        /*  13 */ "property ::= PROP_INDENT(a) prop_value_list(b)",
        /*  14 */ "prop_value_list ::= prop_value(a)",
        /*  15 */ "prop_value_list ::= prop_value(a) prop_value_list(b)",
        /*  16 */ "prop_value ::= SINGLE(a)",
        /*  17 */ "prop_value ::= COMPOSE(a)",
    ]

    // Function definitions

    func yyTokenToSymbol(_ token: CitronToken) -> CitronSymbol {
        return .yy0(token)
    }

    func yyInvokeCodeBlockForRule(ruleNumber: CitronRuleNumber) throws -> CitronSymbol {
        switch (ruleNumber) {
        case 0: /* output ::= collection(a) */
            func codeBlockForRule00(a: [SGFNode]) throws -> [SGFNode] {
    return a
 }
            if case .yy12(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule00(a: a))
            }
        case 1: /* collection ::= gametree(a) */
            func codeBlockForRule01(a: SGFNode) throws -> [SGFNode] {
    return [a]
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule01(a: a))
            }
        case 2: /* collection ::= gametree(a) collection(b) */
            func codeBlockForRule02(a: SGFNode, b: [SGFNode]) throws -> [SGFNode] {
    return [a] + b
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy12(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule02(a: a, b: b))
            }
        case 3: /* gametree ::= OPEN_PARENTHESIS sequence(a) CLOSE_PARENTHESIS */
            func codeBlockForRule03(a: SGFNode) throws -> SGFNode {
    return a
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy15(try codeBlockForRule03(a: a))
            }
        case 4: /* gametree ::= OPEN_PARENTHESIS sequence(a) gametree_list(b) CLOSE_PARENTHESIS */
            func codeBlockForRule04(a: SGFNode, b: [SGFNode]) throws -> SGFNode {
    var node = a
    while node.children.count > 0 {
        node = node.children[0]
    }
    node.children.append(contentsOf: b)
    return a
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy12(let b) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy15(try codeBlockForRule04(a: a, b: b))
            }
        case 5: /* gametree_list ::= gametree(a) */
            func codeBlockForRule05(a: SGFNode) throws -> [SGFNode] {
    return [a]
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule05(a: a))
            }
        case 6: /* gametree_list ::= gametree(a) gametree_list(b) */
            func codeBlockForRule06(a: SGFNode, b: [SGFNode]) throws -> [SGFNode] {
    return [a] + b
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy12(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule06(a: a, b: b))
            }
        case 7: /* sequence ::= node(a) */
            func codeBlockForRule07(a: SGFNode) throws -> SGFNode {
    return a
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy15(try codeBlockForRule07(a: a))
            }
        case 8: /* sequence ::= node(a) sequence(b) */
            func codeBlockForRule08(a: SGFNode, b: SGFNode) throws -> SGFNode {
    a.children.append(b)
    return a
 }
            if case .yy15(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy15(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy15(try codeBlockForRule08(a: a, b: b))
            }
        case 9: /* node ::= SEMICOLUMN */
            func codeBlockForRule09() throws -> SGFNode {
    return SGFNode()
 }
            return .yy15(try codeBlockForRule09())
        case 10: /* node ::= SEMICOLUMN property_list(a) */
            func codeBlockForRule10(a: [(String, [SGFCValueType])]) throws -> SGFNode {
    let node = SGFNode()
    for (k, v) in a {
        node.properties[k] = v
    }
    return node
 }
            if case .yy11(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy15(try codeBlockForRule10(a: a))
            }
        case 11: /* property_list ::= property(a) */
            func codeBlockForRule11(a: (String, [SGFCValueType])) throws -> [(String, [SGFCValueType])] {
    return [a]
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy11(try codeBlockForRule11(a: a))
            }
        case 12: /* property_list ::= property(a) property_list(b) */
            func codeBlockForRule12(a: (String, [SGFCValueType]), b: [(String, [SGFCValueType])]) throws -> [(String, [SGFCValueType])] {
    return [a] + b
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy11(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy11(try codeBlockForRule12(a: a, b: b))
            }
        case 13: /* property ::= PROP_INDENT(a) prop_value_list(b) */
            func codeBlockForRule13(a: SGFToken, b: [SGFCValueType]) throws -> (String, [SGFCValueType]) {
    return (a.toIdentifierString()!, b)
 }
            if case .yy0(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy27(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule13(a: a, b: b))
            }
        case 14: /* prop_value_list ::= prop_value(a) */
            func codeBlockForRule14(a: SGFCValueType) throws -> [SGFCValueType] {
    return [a]
 }
            if case .yy3(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy27(try codeBlockForRule14(a: a))
            }
        case 15: /* prop_value_list ::= prop_value(a) prop_value_list(b) */
            func codeBlockForRule15(a: SGFCValueType, b: [SGFCValueType]) throws -> [SGFCValueType] {
    return [a] + b
 }
            if case .yy3(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy27(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy27(try codeBlockForRule15(a: a, b: b))
            }
        case 16: /* prop_value ::= SINGLE(a) */
            func codeBlockForRule16(a: SGFToken) throws -> SGFCValueType {
    return try a.toSGFCValueType()
 }
            if case .yy0(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy3(try codeBlockForRule16(a: a))
            }
        case 17: /* prop_value ::= COMPOSE(a) */
            func codeBlockForRule17(a: SGFToken) throws -> SGFCValueType {
    return try a.toSGFCValueType()
 }
            if case .yy0(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy3(try codeBlockForRule17(a: a))
            }
        default:
            fatalError("Can't invoke code block for rule number \(ruleNumber) - no such rule")
        }
        fatalError("Can't resolve types correctly for invoking code block for rule number \(ruleNumber)")
    }

    private func yySymbolOnStack(distanceFromTop: Int) -> CitronSymbol {
        assert(yyStack.count > distanceFromTop)
        return yyStack[yyStack.count - 1 - distanceFromTop].symbol
    }

    func yyUnwrapResultFromSymbol(_ symbol: CitronSymbol) -> CitronResult {
        if case .yy12(let result) = symbol {
            return result
        } else {
            fatalError("Unexpected mismatch in result type")
        }
    }

    // Error capturing

    typealias CitronErrorCaptureDelegate = _SGFParserCitronErrorCaptureDelegate

    weak var errorCaptureDelegate: CitronErrorCaptureDelegate? = nil

    let yyErrorCaptureSymbolNumbersForState: [CitronStateNumber:[CitronSymbolNumber]] = [:]
    let yyCanErrorCapture: Bool = false
    let yyErrorCaptureDirectives: [CitronSymbolNumber:(endAfter:[[CitronTokenCode]],endBefore:[CitronTokenCode])] = [:]
    let yyErrorCaptureEndBeforeTokens: Set<CitronSymbolNumber> = []

    let yyErrorCaptureEndAfterSequenceEndingTokens: Set<CitronSymbolNumber> = []

    func yyShouldSaveErrorForCapturing(error: Error) -> Bool {
        fatalError("This parser was not generated with error capturing information")
    }

    func yyCaptureError(on symbolCode: CitronNonTerminalCode, error: Error, state: CitronErrorCaptureState) -> CitronSymbol? {
        fatalError("This parser was not generated with error capturing information")
    }

    func yySymbolContent(_ symbol: CitronSymbol) -> Any { return symbol.typeErasedContent() }

    let yyStartSymbolNumber: CitronSymbolNumber = 17
    let yyEndStateNumber: CitronStateNumber = 11

    var yyErrorCaptureSavedError: (error: Error, isLexerError: Bool)? = nil
    var yyErrorCaptureTokensSinceError: [(token: CitronToken, tokenCode: CitronTokenCode)] = []
    var yyErrorCaptureStackIndices: [Int] = []
    var yyErrorCaptureStartSymbolStackIndex: Int? = nil

    var numberOfCapturedErrors: Int = 0
}

protocol _SGFParserCitronErrorCaptureDelegate : class {
    func shouldSaveErrorForCapturing(error: Error) -> Bool
}

extension _SGFParserCitronErrorCaptureDelegate {
    func shouldSaveErrorForCapturing(error: Error) -> Bool {
        return true
    }
}

// Ability to use == to compare CitronSymbolCode with CitronTokenCode / CitronNonTerminalCode

extension SGFParser.CitronSymbolCode {
    static func == (a: SGFParser.CitronSymbolCode, b: SGFParser.CitronTokenCode) -> Bool {
        guard case let .token(code) = a else { return false }
        return (code == b)
    }
    static func == (a: SGFParser.CitronTokenCode, b: SGFParser.CitronSymbolCode) -> Bool {
        guard case let .token(code) = b else { return false }
        return (code == a)
    }
    static func == (a: SGFParser.CitronSymbolCode, b: SGFParser.CitronNonTerminalCode) -> Bool {
        guard case let .nonterminal(code) = a else { return false }
        return (code == b)
    }
    static func == (a: SGFParser.CitronNonTerminalCode, b: SGFParser.CitronSymbolCode) -> Bool {
        guard case let .nonterminal(code) = b else { return false }
        return (code == a)
    }
}

// Ability to use switch (symbolCode) { case .tokenCode: ...; case .nonterminalCode: ... }

extension SGFParser.CitronSymbolCode {
    static func ~= (pattern: SGFParser.CitronTokenCode, value: SGFParser.CitronSymbolCode) -> Bool {
        return (pattern == value)
    }
    static func ~= (pattern: SGFParser.CitronNonTerminalCode, value: SGFParser.CitronSymbolCode) -> Bool {
        return (pattern == value)
    }
}
