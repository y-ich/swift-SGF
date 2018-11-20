//
//  SGFCursor.swift
//  ChildOfZero
//
//  Created by 市川雄二 on 2018/10/23.
//  Copyright © 2018 New 3 Rs. All rights reserved.
//

import Foundation

class SGFCursor {
    let collection: [SGFNode]
    var current: SGFNode?
    var history = [SGFNode]()

    init() {
        collection = try! parseSGF("(;FF[4]GM[1]SZ[19]KM[7.5])")
        current = collection[0]
    }

    init(_ collection: [SGFNode]) {
        self.collection = collection
        current = collection[0]
    }

    func forward(child: Int = 0) -> SGFNode? {
        if let c = current {
            if child >= c.children.count {
                return nil
            }
            history.append(c)
            current = c.children[child]
            return current
        } else {
            if child >= collection.count {
                return nil
            }
            current = collection[child]
            return current
        }
    }
    
    func back() -> SGFNode? {
        current = history.popLast()
        return current
    }
 
    /// 該当の手があれば進めて、なければ変化を追加する。
    func play(color: String, value: String) {
        guard let c = current else {
            return
        }
        if let i = c.children.firstIndex(where: { $0.properties[color]?.first == value }) {
            let _ = forward(child: i)
        } else if c.children.count > 0 && c.children.allSatisfy({ $0.properties["B"] == nil && $0.properties["W"] == nil }) {
            // FGなどは先に進める
            let _ = forward()
            play(color: color, value: value)
        } else {
            history.append(c)
            let node = SGFNode()
            node.properties[color] = [value]
            c.children.append(node)
            current = node
        }
    }
    
    func hasNext() -> Bool {
        guard let c = current else {
            return false
        }
        return c.children.count > 0
    }
}
