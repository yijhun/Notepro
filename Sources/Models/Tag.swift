import Foundation
import SwiftData

// Core schema for Tag
@Model
final class Tag {
    var id: UUID = UUID()
    var name: String = ""
    var colorHexRaw: String = "#808080"

    var colorHex: String {
        get { colorHexRaw }
        set { colorHexRaw = newValue }
    }
    
    // Relationships
    var notes: [Note]? = nil
    var tasks: [Task]? = nil
    var references: [ZoteroReference]? = nil
    var timeBlocks: [TimeBlock]? = nil
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHexRaw = colorHex
        self.colorHex = colorHex
    }
}
