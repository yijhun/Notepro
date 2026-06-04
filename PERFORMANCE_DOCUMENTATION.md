# Performance Documentation

## SwiftData Models: Computed Properties vs Property Observers

In the context of optimizing the performance of the `Candler` application, this project mandates the use of computed properties instead of `didSet` or `willSet` observers in SwiftData models.

### Rationale

SwiftData relies closely on its underlying persistent storage mechanisms (often CoreData) to track changes and synchronize object graphs. Using `didSet` observers on properties marked with `@Model` can lead to unintended side effects:

1.  **Redundant Writes**: Observers can fire during data population or synchronization, causing immediate and redundant write operations to the database when the object is simply being materialized in memory.
2.  **Context Dirtying**: Modifying properties inside `didSet` can flag the context as "dirty," triggering unneeded re-evaluations, invalidating caches, and slowing down the overall application state.
3.  **Recursion/Synchronization Errors**: In more complex bidirectional architectures or time-tracking objects, observer callbacks have led to unstable synchronization loops or failure in calculating related fields correctly.

### Implementation Guidelines

*   **Avoid `didSet` in `@Model`**: Properties that are derived or recalculated from others (e.g., a `duration` field that depends on `startDate` and `endDate`) should be formulated as dynamically computed properties.
*   **Use Computations**: By defining these fields via getters (`var duration: TimeInterval { max(0, endDate.timeIntervalSince(startDate)) }`), the data remains clean and performs correctly during all database fetches.
*   **Static Caching**: If calculation is extremely heavy, consider alternative caching strategies or manual update methods (e.g., `func recalculate()`) rather than automated observer updates.