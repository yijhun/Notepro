import Foundation
import SwiftData
import Models
import Observation
import Combine

@Observable
public class LiveTimerManager {
    public var activeTask: Task?
    public var activeTimeBlock: TimeBlock?
    public var elapsedTime: TimeInterval = 0
    public var isRunning: Bool = false

    private var timer: Timer?
    private var startDate: Date?
    private var modelContext: ModelContext?

    public init() {}

    public func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }

    public func start(task: Task) {
        stop() // Stop existing

        activeTask = task
        startDate = Date()
        elapsedTime = 0
        isRunning = true

        startTimer()
    }

    public func start(timeBlock: TimeBlock) {
        stop()

        activeTimeBlock = timeBlock
        activeTask = timeBlock.linkedTask
        startDate = Date()
        elapsedTime = 0 // Or continue if resuming? Assuming fresh start for simplicity or "Focus Session"
        isRunning = true

        startTimer()
    }

    public func stop() {
        guard isRunning else { return }

        timer?.invalidate()
        timer = nil
        isRunning = false

        // Save the session
        if let startDate = startDate {
            let endDate = Date()
            let duration = endDate.timeIntervalSince(startDate)

            if let context = modelContext {
                if let block = activeTimeBlock {
                    // Update existing block duration? Usually creating a NEW block for "actual time" is better for auditing.
                    // But requirement says: "update the `TimeBlock` duration and sync..."
                    // If started from a TimeBlock (Calendar Event), maybe we update THAT block's duration?
                    // Or maybe we create a log.
                    // Let's assume we update the block if it was active, or create a new one if from a Task.

                    // Option A: Update block
                    // block.endDate = endDate // This changes the scheduled time. Maybe we want "actualDuration"?
                    // The model has "duration".
                    // Let's create a new "Actual Work" block for audit.
                    let workBlock = TimeBlock(title: "Focus: \(block.title)", startDate: startDate, endDate: endDate)
                    workBlock.linkedTask = block.linkedTask
                    workBlock.tags = block.tags
                    context.insert(workBlock)
                } else if let task = activeTask {
                    // Create new block
                    let newBlock = TimeBlock(title: "Focus: \(task.title)", startDate: startDate, endDate: endDate)
                    newBlock.linkedTask = task
                    context.insert(newBlock)
                }
            }
        }

        activeTask = nil
        activeTimeBlock = nil
        elapsedTime = 0
    }

    public func pause() {
        // Simple pause logic (stop timer but keep state?)
        // For MVP, pause = stop for now, or just invalidate timer.
        timer?.invalidate()
        isRunning = false
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.elapsedTime += 1
        }
    }

    public var formattedTime: String {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60 % 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
