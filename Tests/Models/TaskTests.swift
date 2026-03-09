import XCTest
import SwiftData
@testable import Candler

final class TaskTests: XCTestCase {

    // MARK: - Initialization Tests

    func testTaskInitializationDefaults() {
        // Arrange & Act
        let task = Task(title: "New Task")

        // Assert
        XCTAssertEqual(task.title, "New Task")
        XCTAssertFalse(task.isCompleted)
        XCTAssertNil(task.dueDate)
        XCTAssertEqual(task.priority, 0)
        XCTAssertNotNil(task.createdAt)
        XCTAssertNil(task.embedding)
        // Verify unique ID is generated
        XCTAssertNotNil(task.id)
    }

    func testTaskInitializationCustom() {
        // Arrange
        let id = UUID()
        let date = Date()
        let embedding: [Float] = [0.1, 0.2, 0.3]

        // Act
        let task = Task(
            id: id,
            title: "Custom Task",
            isCompleted: true,
            dueDate: date,
            priority: 2,
            createdAt: date,
            embedding: embedding
        )

        // Assert
        XCTAssertEqual(task.id, id)
        XCTAssertEqual(task.title, "Custom Task")
        XCTAssertTrue(task.isCompleted)
        XCTAssertEqual(task.dueDate, date)
        XCTAssertEqual(task.priority, 2)
        XCTAssertEqual(task.createdAt, date)
        XCTAssertEqual(task.embedding, embedding)
    }

    // MARK: - Protocol Conformance Tests

    func testConformsToTaggable() {
        let task = Task(title: "Taggable Task")
        XCTAssertNil(task.tags)
    }

    func testConformsToTimeBlockable() {
        let task = Task(title: "TimeBlockable Task")
        XCTAssertNil(task.timeBlocks)
    }

    func testConformsToEmbeddable() {
        let task = Task(title: "Embeddable Task")
        XCTAssertNil(task.embedding)
    }
}
