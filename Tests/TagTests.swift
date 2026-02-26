import XCTest
@testable import Models

final class TagTests: XCTestCase {

    // MARK: - Initialization Tests

    func testTagInitialization() {
        // Given
        let name = "Work"
        let colorHex = "#FF0000"
        let id = UUID()

        // When
        let tag = Tag(id: id, name: name, colorHex: colorHex)

        // Then
        XCTAssertEqual(tag.id, id)
        XCTAssertEqual(tag.name, name)
        XCTAssertEqual(tag.colorHex, colorHex)
        XCTAssertNil(tag.notes)
        XCTAssertNil(tag.tasks)
        XCTAssertNil(tag.references)
        XCTAssertNil(tag.timeBlocks)
    }

    func testTagDefaultInitialization() {
        // Given
        let name = "Personal"

        // When
        let tag = Tag(name: name)

        // Then
        XCTAssertNotNil(tag.id)
        XCTAssertEqual(tag.name, name)
        XCTAssertEqual(tag.colorHex, "#808080", "Default color should be gray")
    }

    // MARK: - Relationship Tests

    func testTagRelationships() {
        // Given
        let tag = Tag(name: "Project")
        let note = Note(title: "Project Plan")

        // When
        tag.notes = [note]

        // Then
        XCTAssertNotNil(tag.notes)
        XCTAssertEqual(tag.notes?.count, 1)
        XCTAssertEqual(tag.notes?.first?.title, "Project Plan")

        // Clean up (optional, but good practice if using shared context, though here instances are local)
        tag.notes = nil
        XCTAssertNil(tag.notes)
    }
}
