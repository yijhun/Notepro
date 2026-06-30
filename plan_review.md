1. **Update `Sources/Models/Protocols.swift`**
   - Add `AnyObject` constraint to `Taggable`, `TimeBlockable`, and `Embeddable` protocols to ensure compatibility with SwiftData `@Model` classes.

2. **Update `Sources/Models/Note.swift`**
   - Remove `@Attribute(.unique)` from `id` and assign an inline default `UUID()`.
   - Add `@Attribute(.externalStorage)` to `content` and provide an inline default `""`.
   - Ensure all other properties (`title`, `createdAt`, `modifiedAt`) have inline default values.
   - Keep `@Relationship(inverse:)` macros for `tags`, `references`, `tasks`, `timeBlocks`, and `linkedNotes` to retain parent-side inverse mappings.

3. **Update `Sources/Models/Tag.swift`**
   - Remove `@Attribute(.unique)` from `id`.
   - Provide inline default values for `id` and `name`.
   - Add internal backing property `colorHexRaw` with inline default `"#808080"` and implement `colorHex` as a computed property with a getter and setter that accesses `colorHexRaw`.
   - Update `init` to initialize `colorHexRaw` first before `colorHex`.
   - Include the `// Core schema for Tag` comment.

4. **Update `Sources/Models/Task.swift`**
   - Remove `@Attribute(.unique)` from `id` and provide an inline default `UUID()`.
   - Provide inline default values for all other non-optional properties (`title`, `isCompleted`, `priority`, `createdAt`, `accumulatedTime`).
   - Remove the `@Relationship(inverse: \Note.tasks)` macro from `linkedNote` to prevent double-inverse errors with `Note.tasks`.
   - Keep `@Relationship(inverse:)` for `tags` and `timeBlocks`.

5. **Update `Sources/Models/TimeBlock.swift`**
   - Remove `@Attribute(.unique)` from `id` and `googleEventID`, providing inline default values (`UUID()` and `nil`).
   - Provide inline default values for `title`, `startDate`, `endDate`, and `isAllDay`.
   - Refactor `duration` to be a computed property: `var duration: TimeInterval { max(0, endDate.timeIntervalSince(startDate)) }` and remove the `didSet` observers from `startDate` and `endDate`.
   - Remove `recalculateDuration()` function.
   - Remove `@Relationship(inverse:)` macros from `linkedTask`, `linkedNote`, and `tags` to prevent double-inverses.
   - Ensure `init` enforces `endDate >= startDate` by setting `self.endDate = max(startDate, endDate)`.

6. **Update `Sources/Models/ZoteroReference.swift`**
   - Remove `@Attribute(.unique)` from `id` and `zoteroID` and provide inline default values (`UUID()` and `""`).
   - Provide inline default values for `title` and `authors`.
   - Remove the `@Relationship(inverse: \Note.references)` from `linkedNotes` to prevent double-inverses.
   - Keep the `@Relationship(inverse: \Tag.references)` for `tags`.

7. **Create `Tests/Models/NoteTests.swift`**
   - Use `mkdir -p Tests/Models`.
   - Create the unit test file to verify the `Note` model's initialization logic (default vs custom values) and property mutability, using `@testable import Candler`.

8. **Create `PERFORMANCE_DOCUMENTATION.md`**
   - Create this file in the root directory documenting the rationale for using computed properties over `didSet` observers in SwiftData models to reduce database writes and context dirtying.

9. **Verify all created and updated files**
   - Use `read_file` to verify the contents of all the modified/created files (`Protocols.swift`, `Note.swift`, `Tag.swift`, `Task.swift`, `TimeBlock.swift`, `ZoteroReference.swift`, `NoteTests.swift`, `PERFORMANCE_DOCUMENTATION.md`).

10. **Test codebase**
    - Run `swift test` to check for regressions.

11. **Pre-commit step**
    - Complete pre-commit steps to ensure proper testing, verification, review, and reflection are done.

12. **Submit changes**
    - Commit the code to the repository.
