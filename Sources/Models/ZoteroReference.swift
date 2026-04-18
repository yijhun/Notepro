import Foundation
import SwiftData

@Model // Core schema for ZoteroReference
final class ZoteroReference: Taggable, Embeddable {
    var id: UUID = UUID()
    var zoteroID: String = ""
    
    var title: String = ""
    var authors: [String] = []
    var abstract: String?
    var publicationYear: Int?
    var url: URL?
    
    // Embedding for Semantic Search
    var embeddingData: Data? = nil

    var embedding: [Float]? {
        get { embeddingData?.toFloatArray() }
        set { embeddingData = newValue?.toData() }
    }
    
    // Relationships
    @Relationship(inverse: \Note.references)
    var linkedNotes: [Note]?
    
    @Relationship(inverse: \Tag.references)
    var tags: [Tag]?

    init(
        id: UUID = UUID(),
        zoteroID: String,
        title: String,
        authors: [String] = [],
        abstract: String? = nil,
        publicationYear: Int? = nil,
        url: URL? = nil,
        embedding: [Float]? = nil
    ) {
        self.id = id
        self.zoteroID = zoteroID
        self.title = title
        self.authors = authors
        self.abstract = abstract
        self.publicationYear = publicationYear
        self.url = url
        self.embeddingData = embedding?.toData()
    }
}
