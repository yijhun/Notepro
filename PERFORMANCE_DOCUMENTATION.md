# SwiftData Performance Documentation

## Rationale for Computed Properties over didSet Observers

In SwiftData `@Model` classes, using property observers like `didSet` can cause synchronization and update issues. Modifying properties within observers can trigger unnecessary database writes and unnecessarily dirty the context, reducing performance, especially in scenarios with high-frequency updates.

Instead of relying on `didSet` observers, derived values should be represented as computed properties.

### Example: TimeBlock Duration

Incorrect implementation (using `didSet`):
```swift
@Model
final class TimeBlock {
    var startDate: Date {
        didSet {
            duration = endDate.timeIntervalSince(startDate)
        }
    }

    var endDate: Date {
        didSet {
            duration = endDate.timeIntervalSince(startDate)
        }
    }

    var duration: TimeInterval
    // ...
}
```

Correct implementation (using a computed property):
```swift
@Model
final class TimeBlock {
    var startDate: Date
    var endDate: Date

    var duration: TimeInterval {
        max(0, endDate.timeIntervalSince(startDate))
    }
    // ...
}
```
