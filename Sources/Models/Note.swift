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
    var tags: [Tag]? = []
    
    // Zotero References: Many-to-Many
    var references: [ZoteroReference]? = []
    
    // Tasks associated with this note (e.g. action items inside the note)
    var tasks: [Task]? = []
    
    // TimeBlocks associated with this note (e.g. time spent working on this note)
    var timeBlocks: [TimeBlock]? = []
    
    // Bidirectional Linking
    // Outgoing links: Notes this note links TO
    @Relationship(inverse: \Note.backlinks)
    var linkedNotes: [Note]? = []
    
    // Incoming links: Notes that link TO this note
    var backlinks: [Note]? = []
    
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
        self.embedding = embedding
    }
}
