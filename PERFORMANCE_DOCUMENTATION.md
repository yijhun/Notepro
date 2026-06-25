# Performance Documentation

## SwiftData Models and Computed Properties

In this application, we favor using computed properties over `didSet` observers in SwiftData `@Model` schemas.

### Rationale

Using `didSet` on stored properties within SwiftData models can trigger redundant database writes and dirty the core context unnecessarily. Every time a stored property is modified and its `didSet` observer updates another property, SwiftData may flag multiple changes or create synchronization issues.

For instance, in the `TimeBlock` model, instead of updating `duration` in the `didSet` observers of `startDate` and `endDate`, we calculate `duration` as a computed property dynamically. This ensures data consistency while avoiding additional context changes.

### Best Practices
- **Computed Properties:** Use computed properties for dependent values (e.g., `duration` calculated from `startDate` and `endDate`).
- **Initialization:** Backing raw properties (e.g., `colorHexRaw` in `Tag`) should be explicitly initialized with an inline default value before being wrapped by a computed property that manages the custom validation or setter logic.
- **Attributes:** Do not use `@Attribute(.unique)` on SwiftData properties in this application as it is incompatible with CloudKit syncing. Avoid defining properties as computed if they require local persistence via SwiftData and cannot be derived dynamically.