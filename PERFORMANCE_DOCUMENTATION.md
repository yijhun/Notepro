# Performance Documentation

## Rationale for Using Computed Properties in SwiftData Models

In this project, we prioritize performance and minimizing unnecessary database writes by avoiding `didSet` observers on stored properties within SwiftData `@Model` classes where a computed property would suffice.

### Why Avoid `didSet` in SwiftData?
When a SwiftData model's property is modified, SwiftData flags the model context as "dirty", indicating that changes need to be saved to the underlying storage (e.g., SQLite, CloudKit).

Using `didSet` to calculate and store derived values (such as a `TimeBlock`'s `duration` based on its `startDate` and `endDate`) creates several issues:
1. **Redundant Writes:** Every update to the primary property triggers an update to the derived property, causing extra database writes for data that could simply be computed on the fly.
2. **Synchronization Issues:** When syncing data from external sources (like CloudKit or a remote server), `didSet` observers might not be triggered reliably or might cause unexpected state changes during deserialization.
3. **Context Dirtying:** Even if the derived value doesn't logically change the "core" data, the extra assignment dirties the context, leading to broader and potentially unnecessary save operations.

### The Solution: Computed Properties
By using computed properties for derived data (e.g., `duration: TimeInterval { max(0, endDate.timeIntervalSince(startDate)) }` in `TimeBlock` or `colorHex` computed from `colorHexRaw` in `Tag`), we ensure that:
- The database schema remains clean and only stores the source of truth.
- The SwiftData model context is only dirtied when actual source data changes.
- Performance is improved by avoiding redundant write cycles.

Developers should adhere to this pattern for any values that can be deterministically derived from other stored properties within a model.
