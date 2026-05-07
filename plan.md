1. *Update `Sources/Models/Protocols.swift`*
   - Constrain `Taggable` and `TimeBlockable` to `AnyObject`.
   - Ensure specific protocols are properly structured.
2. *Create `Sources/Models/Extensions.swift`*
   - Implement `Data.toFloatArray()` and `Array<Float>.toData()` for vector embeddings, using pointer memory copy.
3. *Refactor `Sources/Models/Note.swift`*
   - Remove `@Attribute(.unique)` and add inline default values.
   - Refactor `embedding` to a computed property backed by `embeddingData`.
   - Keep `@Relationship(inverse: \Note.backlinks)` on `linkedNotes` and remove inverse from other relationships (so only child defines inverse).
   - Add `// Core schema for Note` comment.
4. *Refactor `Sources/Models/Task.swift`*
   - Remove `@Attribute(.unique)` and add inline defaults.
   - Use `// Core schema for Task`.
   - Refactor `embedding` to a computed property backed by `embeddingData`.
   - Add inverse for `Note.tasks`.
5. *Refactor `Sources/Models/TimeBlock.swift`*
   - Remove `@Attribute(.unique)` and add inline defaults.
   - Use `// Core schema for TimeBlock`.
   - Refactor `duration` to a computed property and remove `didSet`.
6. *Refactor `Sources/Models/ZoteroReference.swift`*
   - Remove `@Attribute(.unique)` and add inline defaults.
   - Use `// Core schema for ZoteroReference`.
   - Refactor `embedding` to computed property backed by `embeddingData`.
7. *Refactor `Sources/Models/Tag.swift`*
   - Remove `@Attribute(.unique)` and add inline defaults.
   - Use `// Core schema for Tag`.
   - Validate color hex correctly with static Regex and use `colorHexRaw`.
   - Add inverse relationships to `Note.tags`, `Task.tags`, `ZoteroReference.tags`, and `TimeBlock.tags`.
8. *Verify files*
   - Read all modified files explicitly (`Sources/Models/Protocols.swift`, `Sources/Models/Extensions.swift`, `Sources/Models/Note.swift`, `Sources/Models/Task.swift`, `Sources/Models/TimeBlock.swift`, `Sources/Models/ZoteroReference.swift`, `Sources/Models/Tag.swift`) in separate verification steps to ensure correctly applied changes.
9. *Run tests*
   - Execute `swift test` to ensure successful compilation and passing tests.
10. *Complete pre-commit steps*
    - Complete pre-commit steps to ensure proper testing, verification, review, and reflection are done.
11. *Submit changes*
    - Submit code using the Git tools provided.
