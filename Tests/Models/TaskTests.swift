import XCTest
@testable import Candler

final class TaskTests: XCTestCase {
    func testPriorityClamping() {
        let lowTask = Task(title: "Low Task", priority: -5)
        XCTAssertEqual(lowTask.priority, 0)

        let validTask = Task(title: "Valid Task", priority: 2)
        XCTAssertEqual(validTask.priority, 2)

        let highTask = Task(title: "High Task", priority: 10)
        XCTAssertEqual(highTask.priority, 3)
    }
}
