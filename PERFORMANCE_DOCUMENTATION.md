# Performance Documentation

## SwiftData Models: Computed Properties vs Property Observers (`didSet`)

When developing SwiftData `@Model` classes, it's highly recommended to utilize computed properties rather than `didSet` observers on stored properties when derived values need to be calculated.

### Rationale

SwiftData relies heavily on CoreData's underlying infrastructure. When a `didSet` observer modifies another property within the same model instance, it triggers additional database writes and unnecessarily dirties the managed object context.

This can lead to several performance and synchronization issues:

1.  **Redundant Writes**: A single update (e.g., changing `startDate` on a `TimeBlock`) can trigger multiple context updates if `duration` is also updated within a `didSet` block.
2.  **Unreliable Triggers**: `didSet` observers on SwiftData `@Model` properties can sometimes behave unreliably due to how SwiftData synthesizes property accessors and manages state, potentially causing synchronization or update failures.
3.  **Context Dirtying**: Modifying a property in a `didSet` dirties the context again, which can trigger infinite loops or unnecessary re-evaluations during save operations.

### Best Practice

Instead of using `didSet`, use computed properties for derived values.

**Instead of:**
```swift
@Model
class Event {
    var startDate: Date {
        didSet { duration = endDate.timeIntervalSince(startDate) }
    }
    var endDate: Date {
        didSet { duration = endDate.timeIntervalSince(startDate) }
    }
    var duration: TimeInterval
}
```

**Do this:**
```swift
@Model
class Event {
    var startDate: Date
    var endDate: Date
    var duration: TimeInterval {
        max(0, endDate.timeIntervalSince(startDate))
    }
}
```

This ensures that the derived value is always correctly calculated on demand without incurring the cost of additional database writes or risking synchronization issues within the SwiftData context.
