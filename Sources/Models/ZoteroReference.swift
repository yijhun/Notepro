import Foundation
import SwiftData

@Model
final class ZoteroReference: Taggable, Embeddable {
    var id: UUID = UUID()
    var zoteroID: String = ""
    
    var title: String = ""
    var authors: [String] = []
    var abstract: String? = nil
    var publicationYear: Int? = nil
    var url: URL? = nil
    
    // Embedding for Semantic Search
    var embedding: [Float]? = nil
    
    // Relationships
    // Assuming Note has a property `references: [ZoteroReference]?`
    var linkedNotes: [Note]? = nil
    
    // Assuming Tag has a property `references: [ZoteroReference]?`
    var tags: [Tag]? = nil

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
        self.embedding = embedding
    }
}
