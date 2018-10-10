//
//  SGFEncoder.swift
//  mimiaka-auto3
//
//  Created by 市川雄二 on 2018/10/06.
//  Copyright © 2018 New 3 Rs. All rights reserved.
//

import Foundation

/// an encoder to stringify a SGF object
public class SGFEncoder {
    /// encodes a collection
    public static func encode(collection: [SGFNode]) -> String {
        return collection.map { self.encode(gameTree: $0) }.joined(separator: "\n")
    }

    static func encode(gameTree: SGFNode) -> String {
        return "(" + encode(node: gameTree) + ")"
    }

    static func encode(node: SGFNode) -> String {
        var result = ";" + node.properties.map {
            let (k, v) = $0
            return k + "[" + v.map { self.encode(cv: $0) }.joined(separator: "][") + "]"
        }.joined()
        if node.children.count == 1 {
            result = result + encode(node: node.children[0])
        } else if node.children.count > 1 {
            result = result + encode(collection: node.children)
        }
        return result
    }
    static func encode(cv: SGFCValueType) -> String {
        switch cv {
        case let .value(v):
            return encode(text: v)
        case let .compose(v1, v2):
            return encode(text: v1) + ":" + encode(text: v2)
        }
    }
    
    static func encode(text: String) -> String {
        return text
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "]", with: "\\]")
            .replacingOccurrences(of: ":", with: "\\:")
    }
}
