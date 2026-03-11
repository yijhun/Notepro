import XCTest
@testable import Candler

final class TimeBlockTests: XCTestCase {
    func testComputedDuration() {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(3600) // 1 hour later

        let block = TimeBlock(title: "Focus Session", startDate: startDate, endDate: endDate)

        XCTAssertEqual(block.duration, 3600)
    }
}
