import Foundation
import SwiftData

@Model
final class Note: Taggable, TimeBlockable, Embeddable {
    @Attribute(.unique) var id: UUID
    var title: String
    @Attribute(.externalStorage) var content: String
    var createdAt: Date
    var modifiedAt: Date
    
    // Embedding for Semantic Search / RAG
    var embeddingData: Data?

    var embedding: [Float]? {
        get { embeddingData?.toFloatArray() }
        set { embeddingData = newValue?.toData() }
    }
    
    // Relationships
    
    // Tags: Many-to-Many
    @Relationship(inverse: \Tag.notes)
    var tags: Set<Tag>?
    
    // Zotero References: Many-to-Many
    @Relationship(inverse: \ZoteroReference.linkedNotes)
    var references: Set<ZoteroReference>?
    
    // Tasks associated with this note (e.g. action items inside the note)
    @Relationship(inverse: \Task.linkedNote)
    var tasks: Set<Task>?
    
    // TimeBlocks associated with this note (e.g. time spent working on this note)
    @Relationship(inverse: \TimeBlock.linkedNote)
    var timeBlocks: Set<TimeBlock>?
    
    // Bidirectional Linking
    // Outgoing links: Notes this note links TO
    @Relationship(inverse: \Note.backlinks)
    var linkedNotes: Set<Note>?
    
    // Incoming links: Notes that link TO this note
    var backlinks: Set<Note>?
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String = "",
        createdAt: Date = Date(),
        modifiedAt: Date = Date(),
        embedding: [Float]? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.embeddingData = embedding?.toData()
    }
}
