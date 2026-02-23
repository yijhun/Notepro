# Candler

Candler is a comprehensive, all-in-one productivity application that seamlessly integrates a Personal Knowledge Management (PKM) system, time-blocking calendar, live task timer, academic reference management, and local AI capabilities.

## Data Models

The project uses SwiftData for local persistence and CloudKit for sync.

### Note
- Stores content, creation/modification dates.
- Supports tagging, linking to other notes (backlinks), and Zotero references.
- Supports vector embeddings for semantic search.

### Task
- Tracks completion status, due date, priority.
- Can be linked to a Note, Tag, and TimeBlocks.
- Supports time tracking (accumulated time).

### TimeBlock
- Represents a calendar event with a start and end time.
- Can be linked to a Task or Note.
- Syncs with Google Calendar.

### Tag
- Categorizes Notes, Tasks, TimeBlocks, and References.
- Has a name and color.

### ZoteroReference
- Stores academic reference metadata (title, authors, abstract, etc.).
- Links to Notes and Tags.
