//
//  ContentViewState.swift
//  OMSDemo
//
//  Created by Takuto Nakamura on 2024/03/02.
//

import Combine
import OpenMultitouchSupport
import SwiftUI

final class ContentViewState: ObservableObject {
    @Published var touchData = [OMSTouchData]()
    @Published var isListening: Bool = false

    private let manager = OMSManager.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        manager.touchDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] touchData in
                self?.touchData = touchData
            }
            .store(in: &cancellables)
    }

    func start() {
        if manager.startListening() {
            isListening = true
        }
    }

    func stop() {
        if manager.stopListening() {
            isListening = false
        }
    }
}
