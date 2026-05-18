import XCTest
import SwiftData
@testable import Candler

final class NoteTests: XCTestCase {

    func testNoteDefaultInitialization() {
        let note = Note(title: "Default Test")

        XCTAssertNotNil(note.id)
        XCTAssertEqual(note.title, "Default Test")
        XCTAssertEqual(note.content, "")
        XCTAssertNotNil(note.createdAt)
        XCTAssertNotNil(note.modifiedAt)
        XCTAssertNil(note.embedding)
        XCTAssertNil(note.embeddingData)

        XCTAssertNil(note.tags)
        XCTAssertNil(note.references)
        XCTAssertNil(note.tasks)
        XCTAssertNil(note.timeBlocks)
        XCTAssertNil(note.linkedNotes)
        XCTAssertNil(note.backlinks)
    }

    func testNoteCustomInitialization() {
        let customID = UUID()
        let customDate = Date(timeIntervalSince1970: 1000)
        let customEmbedding: [Float] = [0.1, 0.2, 0.3]

        let note = Note(
            id: customID,
            title: "Custom Title",
            content: "Custom Content",
            createdAt: customDate,
            modifiedAt: customDate,
            embedding: customEmbedding
        )

        XCTAssertEqual(note.id, customID)
        XCTAssertEqual(note.title, "Custom Title")
        XCTAssertEqual(note.content, "Custom Content")
        XCTAssertEqual(note.createdAt, customDate)
        XCTAssertEqual(note.modifiedAt, customDate)

        XCTAssertNotNil(note.embedding)
        XCTAssertEqual(note.embedding?.count, 3)
        XCTAssertEqual(note.embedding?[0], 0.1)
        XCTAssertNotNil(note.embeddingData)
    }

    func testNotePropertyMutability() {
        let note = Note(title: "Initial Title")

        note.title = "Updated Title"
        note.content = "New Body"

        let newEmbedding: [Float] = [0.9, 0.8]
        note.embedding = newEmbedding

        XCTAssertEqual(note.title, "Updated Title")
        XCTAssertEqual(note.content, "New Body")
        XCTAssertEqual(note.embedding?.count, 2)
        XCTAssertEqual(note.embedding?[0], 0.9)
    }
}
