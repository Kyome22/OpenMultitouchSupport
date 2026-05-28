/*
 OMSTouchData.swift

 Created by Takuto Nakamura on 2024/03/02.
 */

import OpenMultitouchSupportXCF

public struct OMSPosition: Sendable {
    public var x: Float
    public var y: Float
}

public struct OMSAxis: Sendable {
    public var major: Float
    public var minor: Float
}

public enum OMSState: String, Sendable {
    case notTouching
    case starting
    case hovering
    case making
    case touching
    case breaking
    case lingering
    case leaving

    init?(_ state: OpenMTState) {
        guard let newValue = Self.create(from: state) else {
            return nil
        }
        self = newValue
    }

    private static func create(from state: OpenMTState) -> OMSState? {
        switch state {
        case .notTouching: .notTouching
        case .starting: .starting
        case .hovering: .hovering
        case .making: .making
        case .touching: .touching
        case .breaking: .breaking
        case .lingering: .lingering
        case .leaving: .leaving
        @unknown default:  nil
        }
    }
}

public struct OMSTouchData: CustomStringConvertible, Sendable {
    public var id: Int32
    public var position: OMSPosition
    public var total: Float
    public var pressure: Float
    public var axis: OMSAxis
    public var angle: Float
    public var density: Float
    public var state: OMSState
    public var timestamp: String

    public var description: String {
        var text = String(format: "id:%2d, ", id)
        text += String(format: "pos:(%05.3f,%05.3f), ", position.x, position.y)
        text += String(format: "total:%05.3f, ", total)
        text += String(format: "pressure:%05.3f, ", pressure)
        text += String(format: "axis(%05.3f,%05.3f), ", axis.major, axis.minor)
        text += String(format: "angle:%05.3f, ", angle)
        text += String(format: "density:%05.3f, ", density)
        text += "\(state.rawValue), \(timestamp)"
        return text
    }
}
