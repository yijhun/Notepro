import Foundation
import SwiftData

@Model
public final class Note: Taggable, TimeBlockable, Embeddable {
    @Attribute(.unique) public var id: UUID
    public var title: String
    public var content: String
    public var createdAt: Date
    public var modifiedAt: Date
    
    // Embedding for Semantic Search / RAG
    public var embedding: [Float]?
    
    // Relationships
    
    // Tags: Many-to-Many
    @Relationship(inverse: \Tag.notes)
    public var tags: [Tag]?
    
    // Zotero References: Many-to-Many
    @Relationship(inverse: \ZoteroReference.linkedNotes)
    public var references: [ZoteroReference]?
    
    // Tasks associated with this note (e.g. action items inside the note)
    @Relationship(deleteRule: .cascade, inverse: \Task.linkedNote)
    public var tasks: [Task]?
    
    // TimeBlocks associated with this note (e.g. time spent working on this note)
    @Relationship(inverse: \TimeBlock.linkedNote)
    public var timeBlocks: [TimeBlock]?
    
    // Bidirectional Linking
    // Outgoing links: Notes this note links TO
    @Relationship(inverse: \Note.backlinks)
    public var linkedNotes: [Note]?
    
    // Incoming links: Notes that link TO this note
    public var backlinks: [Note]?
    
    public init(
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
        self.embedding = embedding
    }
}
