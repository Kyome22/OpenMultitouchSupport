/*
 AsyncStreamBundle.swift

 Created by Takuto Nakamura on 2026/05/28.
 */

import AsyncAlgorithms

public typealias AsyncShareStream<T: Sendable> = Sendable & AsyncSequence<T, AsyncStream<T>.__AsyncSequence_Failure>

struct AsyncStreamBundle<T>: Sendable where T: Sendable {
    public let stream: any AsyncShareStream<T>
    private let continuation: AsyncStream<T>.Continuation

    init() {
        let (stream, continuation) = AsyncStream.makeStream(
            of: T.self,
            bufferingPolicy: .bufferingNewest(1)
        )
        self.stream = stream.share(bufferingPolicy: .bufferingLatest(1))
        self.continuation = continuation
    }

    func send(_ value: T) {
        continuation.yield(value)
    }
}
