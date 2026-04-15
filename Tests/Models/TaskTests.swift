import XCTest
import Foundation
@testable import Candler

final class TaskTests: XCTestCase {

    func testTaskInitializationWithDefaultValues() {
        let task = Task(title: "Test Task")

        XCTAssertEqual(task.title, "Test Task")
        XCTAssertFalse(task.isCompleted)
        XCTAssertNil(task.dueDate)
        XCTAssertEqual(task.priority, 0)
        XCTAssertNil(task.embedding)
        XCTAssertNil(task.timerStartTime)
        XCTAssertEqual(task.accumulatedTime, 0)
        XCTAssertNil(task.linkedNote)
        XCTAssertNil(task.tags)
        XCTAssertNil(task.timeBlocks)
    }

    func testTaskInitializationWithCustomValues() {
        let id = UUID()
        let dueDate = Date()
        let createdAt = Date()
        let embedding: [Float] = [0.1, 0.2, 0.3]
        let timerStartTime = Date()

        let task = Task(
            id: id,
            title: "Custom Task",
            isCompleted: true,
            dueDate: dueDate,
            priority: 3,
            createdAt: createdAt,
            embedding: embedding,
            timerStartTime: timerStartTime,
            accumulatedTime: 3600
        )

        XCTAssertEqual(task.id, id)
        XCTAssertEqual(task.title, "Custom Task")
        XCTAssertTrue(task.isCompleted)
        XCTAssertEqual(task.dueDate, dueDate)
        XCTAssertEqual(task.priority, 3)
        XCTAssertEqual(task.createdAt, createdAt)
        XCTAssertEqual(task.embedding, embedding)
        XCTAssertEqual(task.timerStartTime, timerStartTime)
        XCTAssertEqual(task.accumulatedTime, 3600)
    }

    func testTaskPropertyUpdates() {
        let task = Task(title: "Initial")

        task.title = "Updated"
        task.isCompleted = true
        task.priority = 1
        task.accumulatedTime = 60

        XCTAssertEqual(task.title, "Updated")
        XCTAssertTrue(task.isCompleted)
        XCTAssertEqual(task.priority, 1)
        XCTAssertEqual(task.accumulatedTime, 60)
    }
}
