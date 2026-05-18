# Performance Documentation

## SwiftData Model Properties

This project uses computed properties for derivative or validated data in SwiftData models instead of `didSet` observers.

### Rationale

Using `didSet` observers on SwiftData `@Model` properties can lead to performance issues and unexpected behavior:
1.  **Synchronization/Update Issues:** `didSet` observers often do not fire reliably within the context of SwiftData's change tracking mechanism.
2.  **Context Dirtying:** Modifying properties within a `didSet` observer marks the model context as dirty, leading to unnecessary and frequent database writes.

### Implementation Pattern

Instead of:
```swift
var startDate: Date {
    didSet {
        duration = endDate.timeIntervalSince(startDate)
    }
}
var duration: TimeInterval
```

We use a computed property that dynamically evaluates the required value, keeping the underlying stored properties as simple source-of-truth values:
```swift
var startDate: Date
var endDate: Date
var duration: TimeInterval { max(0, endDate.timeIntervalSince(startDate)) }
```

This pattern ensures accurate data evaluation without triggering redundant state changes or database saves.
