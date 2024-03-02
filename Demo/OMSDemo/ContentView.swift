//
//  ContentView.swift
//  OMSDemo
//
//  Created by Takuto Nakamura on 2024/03/02.
//

import SwiftUI
import OpenMultitouchSupport

struct ContentView: View {
    @StateObject var viewState = ContentViewState()

    var body: some View {
        VStack {
            if viewState.isListening {
                Button {
                    viewState.stop()
                } label: {
                    Text(verbatim: "Stop")
                }
            } else {
                Button {
                    viewState.start()
                } label: {
                    Text(verbatim: "Start")
                }
            }
            Canvas { context, size in
                viewState.touchData.forEach { touch in
                    let path = makeEllipse(touch: touch, size: size)
                    context.fill(path, with: .color(.primary.opacity(Double(touch.total))))
                }
            }
            .frame(width: 600, height: 400)
            .border(Color.primary)
        }
        .fixedSize()
        .padding()
    }

    private func makeEllipse(touch: OMSTouchData, size: CGSize) -> Path {
        let x = Double(touch.position.x) * size.width
        let y = Double(1.0 - touch.position.y) * size.height
        let u = size.width / 100.0
        let w = Double(touch.axis.major) * u
        let h = Double(touch.axis.minor) * u
        return Path(ellipseIn: CGRect(x: -0.5 * w, y: -0.5 * h, width: w, height: h))
            .rotation(.radians(Double(-touch.angle)), anchor: .topLeading)
            .offset(x: x, y: y)
            .path(in: CGRect(origin: .zero, size: size))
    }
}

#Preview {
    ContentView()
}
