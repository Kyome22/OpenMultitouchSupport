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
    let axis: FloatPair
    let angle: Float
    let size: Float
    let density: Float
    let state: String
    let timestamp: String
    
    var description: String {
        return  String(format: "%d,%08.6f,%08.6f,%08.6f,%08.6f,%08.6f,%08.6f,%08.6f,%@,%@\n",
                       id, pos.x, pos.y, axis.x, axis.y, angle, size, density, state, timestamp)
    }
    var explanation: String {
        return  String(format: "id:%d, pos:(%05.3f,%05.3f), axis(%06.3f,%05.3f), angle:%05.3f, size:%05.3f, density:%05.3f, %@, %@",
                       id, pos.x, pos.y, axis.x, axis.y, angle, size, density, state, timestamp)
    }
}

