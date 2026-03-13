import XCTest
@testable import Candler

final class TimeBlockTests: XCTestCase {
    func testDurationCalculation() {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(3600) // 1 hour
        let timeBlock = TimeBlock(title: "Test", startDate: startDate, endDate: endDate)

        XCTAssertEqual(timeBlock.duration, 3600)
    }
}
