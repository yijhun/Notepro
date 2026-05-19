# Performance Documentation

## Rationale for using computed properties over `didSet` observers in SwiftData models

In SwiftData models, the use of `didSet` property observers on stored properties has been shown to cause synchronization and update issues. More importantly, when `didSet` observers trigger updates within a model, it can inadvertently dirty the SwiftData context and lead to excessive and unnecessary database writes.

By utilizing computed properties (e.g., calculating `duration` based on `startDate` and `endDate` inside the `TimeBlock` model getter instead of relying on a `didSet` observer), we eliminate unnecessary write operations to the persistent store. This approach optimizes performance and reduces context dirtying, leading to smoother updates and fewer synchronization conflicts with CloudKit and external APIs.
