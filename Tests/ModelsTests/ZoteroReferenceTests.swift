import XCTest
import SwiftData
@testable import CandlerModels

final class ZoteroReferenceTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!

    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: ZoteroReference.self, Note.self, Tag.self, configurations: config)
        modelContext = ModelContext(modelContainer)
    }

    override func tearDownWithError() throws {
        modelContainer = nil
        modelContext = nil
    }

    func testInitialization() throws {
        let reference = ZoteroReference(
            zoteroID: "TEST1234",
            title: "Test Title",
            authors: ["Author One", "Author Two"],
            publicationYear: 2023
        )

        XCTAssertEqual(reference.zoteroID, "TEST1234")
        XCTAssertEqual(reference.title, "Test Title")
        XCTAssertEqual(reference.authors.count, 2)
        XCTAssertEqual(reference.publicationYear, 2023)
        XCTAssertNil(reference.abstract)
        XCTAssertNil(reference.url)
    }

    func testOptionalProperties() throws {
        let url = URL(string: "https://example.com")
        let reference = ZoteroReference(
            zoteroID: "OPTIONAL123",
            title: "Optional Test",
            abstract: "This is an abstract",
            url: url
        )

        XCTAssertEqual(reference.abstract, "This is an abstract")
        XCTAssertEqual(reference.url, url)
    }

    func testRelationships() throws {
        let reference = ZoteroReference(
            zoteroID: "REL123",
            title: "Relationship Test"
        )
        modelContext.insert(reference)

        let tag = Tag(name: "Science", colorHex: "#FF0000")
        modelContext.insert(tag)

        reference.tags = [tag]

        // Save context to persist relationships (in memory)
        try modelContext.save()

        XCTAssertEqual(reference.tags?.count, 1)
        XCTAssertEqual(reference.tags?.first?.name, "Science")
        XCTAssertEqual(tag.references?.count, 1)
        XCTAssertEqual(tag.references?.first?.zoteroID, "REL123")

        let note = Note(title: "Research Note")
        modelContext.insert(note)

        reference.linkedNotes = [note]

        try modelContext.save()

        XCTAssertEqual(reference.linkedNotes?.count, 1)
        XCTAssertEqual(reference.linkedNotes?.first?.title, "Research Note")
        XCTAssertEqual(note.references?.count, 1)
        XCTAssertEqual(note.references?.first?.zoteroID, "REL123")
    }

    func testPersistence() throws {
        let reference = ZoteroReference(
            zoteroID: "PERSIST123",
            title: "Persistence Test"
        )
        modelContext.insert(reference)
        try modelContext.save()

        let descriptor = FetchDescriptor<ZoteroReference>(predicate: #Predicate { $0.zoteroID == "PERSIST123" })
        let fetchedReferences = try modelContext.fetch(descriptor)

        XCTAssertEqual(fetchedReferences.count, 1)
        XCTAssertEqual(fetchedReferences.first?.title, "Persistence Test")
    }

    func testUniqueConstraint() throws {
        let reference1 = ZoteroReference(zoteroID: "UNIQUE123", title: "First")
        modelContext.insert(reference1)

        let reference2 = ZoteroReference(zoteroID: "UNIQUE123", title: "Second")
        modelContext.insert(reference2)

        // Attempting to save should throw an error due to unique constraint violation on zoteroID
        // Note: Both have different UUIDs (default init), but same zoteroID which is @Attribute(.unique)
        XCTAssertThrowsError(try modelContext.save())
    }
}
