//
//  TouchData.swift
//  OpenMultitouchDemo
//
//  Created by Takuto Nakamura on 2019/09/12.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//

import Foundation

struct FloatPair {
    var x: Float
    var y: Float
}

struct TouchData {
    let id: Int32
    let pos: FloatPair
    let total: Float
    let pressure: Float
    let axis: FloatPair
    let angle: Float
    let density: Float
    let state: String
    let timestamp: String
    
    var description: String {
        return  String(format: "%2d,%05.3f,%05.3f,%05.3f,%05.3f,%05.3f,%05.3f,%05.3f,%05.3f,%@,%@\n",
                       id, pos.x, pos.y, total, pressure, axis.x, axis.y, angle, density, state, timestamp)
    }
    var explanation: String {
        return  String(format: "id:%2d, pos:(%05.3f,%05.3f), total:%05.3f, pressure:%05.3f, axis(%05.3f,%05.3f), angle:%05.3f, density:%05.3f, %@, %@",
                       id, pos.x, pos.y, total, pressure, axis.x, axis.y, angle, density, state, timestamp)
    }
}

