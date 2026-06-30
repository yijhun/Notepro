# Performance Documentation

## Rationale for using computed properties over `didSet` observers in SwiftData Models

In SwiftData, using `didSet` property observers on `@Model` stored properties can cause unexpected side effects and performance issues. Every time a property is set, the `didSet` block gets executed, potentially causing further modifications. If those further modifications trigger updates to relationships or multiple internal properties, they can dirty the model context more often than necessary or cause synchronization and update issues. This is especially impactful when there are automatic updates like syncing with CloudKit.

Therefore, for cases like a time block's `duration` which strictly depends on `startDate` and `endDate`, it's much safer and more performant to define it as a computed property rather than eagerly calculating and storing it inside a `didSet` observer. Computed properties ensure that no additional database writes are triggered to recalculate dependent fields and context dirtying is minimized.