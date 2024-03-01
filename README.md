# OpenMultitouchSupport

This enables you easily to observe global multitouch events on the trackpad (Built-In only).  
I created this library to make MultitouchSupport.framework (Private Framework) easy to use.

## References

This library refers the following frameworks very much. Special Thanks!

- [mhuusko5/M5MultitouchSupport](https://github.com/mhuusko5/M5MultitouchSupport)
- [calftrail/Touch](https://github.com/calftrail/Touch/blob/master/TouchSynthesis/MultitouchSupport.h)

## Requirements

- Development with Xcode 15.2+
- swift-tools-version: 5.9
- Compatible with macOS 12.0+

## Usage (Swift)

```swift
import OpenMultitouchSupport
import Combine

var cancellables = Set<AnyCancellable>()

let manager = OMSManager.shared()
manager.touchDataPublisher
    .sink { touchData in 
        // ・・・
    }
    .store(in: &cancellables)

manager.startListening()
manager.stopListening()
```

### The data you can get are as follows

```swift
struct OMSPosition {
    var x: Float
    var y: Float
}

struct OMSAxis {
    var major: Float
    var minor: Float
}

enum OMSState: String {
    case notTouching
    case starting
    case hovering
    case making
    case touching
    case breaking
    case lingering
    case leaving
}

struct OMSTouchData {
    var id: Int32
    var pos: OMSPosition
    var total: Float // total value of capacitance
    var pressure: Float
    var axis: OMSAxis
    var angle: Float // finger angle
    var density: Float // area density of capacitance
    var state: OMSState
    var timestamp: String
}
```

## Build OpenMultitouchSupportXCF.xcframework

```sh
$ sh build_framework.sh
```
