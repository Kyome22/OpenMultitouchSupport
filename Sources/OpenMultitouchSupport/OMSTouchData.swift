/*
 OMSTouchData.swift

 Created by Takuto Nakamura on 2024/03/02.
*/

import Foundation

public struct OMSFloatPair {
    public var x: Float
    public var y: Float
}

public struct OMSTouchData: CustomStringConvertible {
    public var id: Int32
    public var pos: OMSFloatPair
    public var total: Float
    public var pressure: Float
    public var axis: OMSFloatPair
    public var angle: Float
    public var density: Float
    public var state: String
    public var timestamp: String

    public var description: String {
        var text = String(format: "id:%2d, ", id)
        text += String(format: "pos:(%05.3f,%05.3f), ", pos.x, pos.y)
        text += String(format: "total:%05.3f, ", total)
        text += String(format: "pressure:%05.3f, ", pressure)
        text += String(format: "axis(%05.3f,%05.3f), ", axis.x, axis.y)
        text += String(format: "angle:%05.3f, ", angle)
        text += String(format: "density:%05.3f, ", density)
        text += "\(state), \(timestamp)"
        return text
    }
}
