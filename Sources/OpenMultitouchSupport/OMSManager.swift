/*
 OMSManager.swift

 Created by Takuto Nakamura on 2024/03/02.
*/

import OpenMultitouchSupportXCF
import Combine

public final class OMSManager {
    public let shared = OMSManager()
    private let xcfManager = OpenMTManager.shared()
    private let dateFormatter = DateFormatter()
    private var listener: OpenMTListener?

    private let touchDataSubject = PassthroughSubject<[OMSTouchData], Never>()
    public var touchDataPublisher: AnyPublisher<[OMSTouchData], Never> {
        touchDataSubject.eraseToAnyPublisher()
    }

    private init() {
        dateFormatter.dateFormat = "HH:mm:ss.SSSS"
    }

    deinit {
        if let xcfManager, let listener {
            xcfManager.remove(listener)
        }
    }

    @discardableResult
    public func startListening() -> Bool {
        guard let xcfManager, listener == nil else { return false }
        listener = xcfManager.addListener(
            withTarget: self,
            selector: #selector(listen)
        )
        return true
    }

    @discardableResult
    public func stopListening() -> Bool {
        guard let xcfManager, let listener else { return false }
        xcfManager.remove(listener)
        self.listener = nil
        return true
    }

    @objc func listen(_ event: OpenMTEvent) {
        guard let touches = (event.touches as NSArray) as? [OpenMTTouch] else { return }
        if touches.isEmpty {
            touchDataSubject.send([])
        } else {
            let array = touches.compactMap { touch -> OMSTouchData? in
                guard let state = OMSState(touch.state) else { return nil }
                return OMSTouchData(
                    id: touch.identifier,
                    pos: OMSPosition(x: touch.posX, y: touch.posY),
                    total: touch.total,
                    pressure: touch.pressure,
                    axis: OMSAxis(major: touch.majorAxis, minor: touch.minorAxis),
                    angle: touch.angle,
                    density: touch.density,
                    state: state,
                    timestamp: dateFormatter.string(from: Date())
                )
            }
            touchDataSubject.send(array)
        }
    }
}
