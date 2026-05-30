# Performance Documentation

## SwiftData Models and Computed Properties

In this application, we favor using computed properties rather than `didSet` observers on stored properties within SwiftData `@Model` classes (for example, in `TimeBlock` for `duration`).

### Rationale

1. **Database Writes**: Modifying a stored property in a `didSet` block triggers an additional write operation. By relying on a computed property, we derive the necessary value on read, eliminating unnecessary redundant updates.
2. **Context Dirtying**: Repeatedly altering state inside a property observer can prematurely or repeatedly dirty the `ModelContext`. This can lead to inefficient synchronization loops, especially when multiple related objects are updated simultaneously or when interacting with CloudKit.
3. **Reliability**: SwiftData's macro generation does not always interact predictably with `didSet` property observers on stored attributes, which can result in properties failing to update correctly. Computed properties guarantee up-to-date derivation based on the current state.
