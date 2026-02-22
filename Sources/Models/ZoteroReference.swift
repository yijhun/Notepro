import Foundation
import SwiftData

/// A reference item synchronized from Zotero.
@Model
public final class ZoteroReference: Taggable, Embeddable {
    @Attribute(.unique) public var id: UUID
    @Attribute(.unique) public var zoteroID: String
    
    public var title: String
    public var authors: [String]
    public var abstract: String?
    public var publicationYear: Int?
    public var url: URL?
    
    // Embedding for Semantic Search
    public var embedding: [Float]?
    
    // Relationships
    // Assuming Note has a property `references: [ZoteroReference]?`
    @Relationship(inverse: \Note.references)
    public var linkedNotes: [Note]?
    
    // Assuming Tag has a property `references: [ZoteroReference]?`
    @Relationship(inverse: \Tag.references)
    public var tags: [Tag]?

    public init(
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
