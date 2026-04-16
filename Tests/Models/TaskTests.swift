import XCTest
import SwiftData
@testable import Candler

final class TaskTests: XCTestCase {

    func testTaskInitializationWithDefaultValues() {
        let task = Task(title: "Default Task")

        XCTAssertEqual(task.title, "Default Task")
        XCTAssertFalse(task.isCompleted)
        XCTAssertNil(task.dueDate)
        XCTAssertEqual(task.priority, 0)
        XCTAssertNil(task.embedding)
        XCTAssertNil(task.timerStartTime)
        XCTAssertEqual(task.accumulatedTime, 0)
    }

    func testTaskInitializationWithCustomValues() {
        let date = Date()
        let embedding: [Float] = [0.1, 0.2, 0.3]
        let timerStart = Date()

        let task = Task(
            title: "Custom Task",
            isCompleted: true,
            dueDate: date,
            priority: 2,
            embedding: embedding,
            timerStartTime: timerStart,
            accumulatedTime: 3600
        )

        XCTAssertEqual(task.title, "Custom Task")
        XCTAssertTrue(task.isCompleted)
        XCTAssertEqual(task.dueDate, date)
        XCTAssertEqual(task.priority, 2)
        XCTAssertEqual(task.embedding, embedding)
        XCTAssertEqual(task.timerStartTime, timerStart)
        XCTAssertEqual(task.accumulatedTime, 3600)
    }

    func testTaskPropertyUpdates() {
        let task = Task(title: "Updatable Task")

        task.title = "Updated Title"
        task.isCompleted = true
        task.priority = 3
        task.accumulatedTime += 1800

        XCTAssertEqual(task.title, "Updated Title")
        XCTAssertTrue(task.isCompleted)
        XCTAssertEqual(task.priority, 3)
        XCTAssertEqual(task.accumulatedTime, 1800)
    }
}
