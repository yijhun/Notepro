import SwiftUI
import SwiftData
import Models
import UniformTypeIdentifiers

public struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(LiveTimerManager.self) private var timerManager
    @Query private var timeBlocks: [TimeBlock]

    // Grid settings
    private let hourHeight: CGFloat = 60.0

    public init() {}

    public var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                // Background Grid
                VStack(spacing: 0) {
                    ForEach(0..<24, id: \.self) { hour in
                        HStack(alignment: .top) {
                            Text(String(format: "%02d:00", hour))
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .frame(width: 50, alignment: .trailing)
                                .padding(.trailing, 8)

                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(height: hourHeight, alignment: .top)
                    }
                }

                // Time Blocks Overlay
                ForEach(timeBlocks) { block in
                    TimeBlockView(block: block, hourHeight: hourHeight)
                        .padding(.leading, 60) // Offset for time labels
                        .contextMenu {
                            Button {
                                timerManager.start(timeBlock: block)
                            } label: {
                                Label("Start Focus", systemImage: "timer")
                            }
                            Button(role: .destructive) {
                                modelContext.delete(block)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .contentShape(Rectangle()) // Make the empty space interactive
            .dropDestination(for: TaskDraggable.self) { items, location in
                handleDrop(items: items, location: location)
            }
        }
        .navigationTitle("Calendar")
    }

    private func handleDrop(items: [TaskDraggable], location: CGPoint) -> Bool {
        guard let item = items.first else { return false }

        let totalHours = location.y / hourHeight
        let hour = Int(totalHours)
        let minute = Int((totalHours - CGFloat(hour)) * 60)

        let snappedMinute = (minute / 15) * 15

        var calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = snappedMinute

        guard let startDate = calendar.date(from: components) else { return false }
        let endDate = startDate.addingTimeInterval(3600) // Default 1 hour duration

        let taskID = item.id
        let descriptor = FetchDescriptor<Task>(predicate: #Predicate { $0.id == taskID })

        do {
            if let task = try modelContext.fetch(descriptor).first {
                let newBlock = TimeBlock(
                    title: task.title,
                    startDate: startDate,
                    endDate: endDate
                )
                newBlock.linkedTask = task
                modelContext.insert(newBlock)
                return true
            }
        } catch {
            print("Error fetching task: \(error)")
            return false
        }

        return false
    }
}

struct TimeBlockView: View {
    let block: TimeBlock
    let hourHeight: CGFloat

    var body: some View {
        let calendar = Calendar.current
        let startHour = calendar.component(.hour, from: block.startDate)
        let startMinute = calendar.component(.minute, from: block.startDate)

        let topOffset = (CGFloat(startHour) * hourHeight) + (CGFloat(startMinute) / 60.0 * hourHeight)
        let durationHours = block.duration / 3600.0
        let height = CGFloat(durationHours) * hourHeight

        RoundedRectangle(cornerRadius: 8)
            .fill(Color.blue.opacity(0.3))
            .overlay(
                Text(block.title)
                    .font(.caption)
                    .padding(4),
                alignment: .topLeading
            )
            .frame(height: max(height, 20)) // Minimum height
            .offset(y: topOffset)
            .padding(.trailing, 8)
    }
}
