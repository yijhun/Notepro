import Foundation
import SwiftData

@Model // Core schema for ZoteroReference
final class ZoteroReference: Taggable, Embeddable {
    var id: UUID = UUID()
    var zoteroID: String = ""
    
    var title: String = ""
    var authors: [String] = []
    var abstract: String? = nil
    var publicationYear: Int? = nil
    var url: URL? = nil
    
    // Embedding for Semantic Search
    var embeddingData: Data?

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
        zoteroID: String = "",
        title: String = "",
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
        if let url = url, let scheme = url.scheme, ["http", "https"].contains(scheme.lowercased()) {
            self.url = url
        } else {
            self.url = nil
        }
        self.embedding = embedding
    }
}
