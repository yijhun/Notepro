import Foundation
import SwiftData

@Model // Core schema for Note
final class Note: Taggable, TimeBlockable, Embeddable {
    var id: UUID = UUID()
    var title: String = ""
    @Attribute(.externalStorage) var content: String = ""
    var createdAt: Date = Date()
    var modifiedAt: Date = Date()
    
    // Embedding for Semantic Search / RAG
    var embeddingData: Data? = nil
    var embedding: [Float]? {
        get { embeddingData?.toFloatArray() }
        set { embeddingData = newValue?.toData() }
    }
    
    // Relationships
    
    // Tags: Many-to-Many
    @Relationship(inverse: \Tag.notes)
    var tags: [Tag]? = nil
    
    // Zotero References: Many-to-Many
    @Relationship(inverse: \ZoteroReference.linkedNotes)
    var references: [ZoteroReference]? = nil
    
    // Tasks associated with this note
    @Relationship(inverse: \Task.linkedNote)
    var tasks: [Task]? = nil
    
    // TimeBlocks associated with this note
    @Relationship(inverse: \TimeBlock.linkedNote)
    var timeBlocks: [TimeBlock]? = nil
    
    // Bidirectional Linking
    // Outgoing links: Notes this note links TO
    @Relationship(inverse: \Note.backlinks)
    var linkedNotes: [Note]? = nil
    
    // Incoming links: Notes that link TO this note
    var backlinks: [Note]? = nil
    
    init(
        id: UUID = UUID(),
        title: String = "",
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
