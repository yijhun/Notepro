import Foundation
import SwiftData

@Model // Core schema for Tag
final class Tag {
    var id: UUID = UUID()
    var name: String = ""
    var colorHexRaw: String = "#808080"
    var colorHex: String {
        get { colorHexRaw }
        set { colorHexRaw = newValue }
    }
    
    // Relationships
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String = "", colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHexRaw = colorHex
    }
}
