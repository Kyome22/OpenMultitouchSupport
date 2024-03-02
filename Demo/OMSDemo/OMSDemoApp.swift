//
//  OMSDemoApp.swift
//  OMSDemo
//
//  Created by Takuto Nakamura on 2024/03/02.
//

import SwiftUI

@main
struct OMSDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizabilityIfPossible()
    }
}

extension Scene {
    func windowResizabilityIfPossible() -> some Scene {
        if #available(macOS 13.0, *) {
            return self.windowResizability(.contentSize)
        }
        return self
    }
}
