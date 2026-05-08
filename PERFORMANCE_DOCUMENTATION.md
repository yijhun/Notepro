# Performance Documentation

## SwiftData Model Computed Properties vs. Property Observers (`didSet`)

In the SwiftData models for Candler, we use **computed properties** rather than **`didSet` observers** for derived values (like `duration` on `TimeBlock` or `colorHex` on `Tag`).

### Rationale:
1. **Database Writes**: Property observers (`didSet`, `willSet`) on SwiftData `@Model` classes trigger whenever the underlying value is manipulated or fetched by the framework. This can lead to excessive and unwanted database writes.
2. **Context Dirtying**: Modifying a property within a `didSet` observer marks the entire model context as "dirty", which causes the persistent store to assume changes have been made even on a simple fetch, degrading read performance.
3. **Synchronization Issues**: Computed properties calculate the value on-the-fly and rely strictly on the source-of-truth stored properties (e.g., computing `duration` from `startDate` and `endDate`), meaning the database remains pure and only explicit mutations trigger writes and UI updates.
