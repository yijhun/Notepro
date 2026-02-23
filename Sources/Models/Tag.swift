import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    var colorHex: String
    
    // Relationships
    // The inverse relationships are defined in the respective models
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHex = colorHex
    }
}
