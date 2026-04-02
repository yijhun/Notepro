import Foundation
import SwiftData

@Model
final class Tag {
    static let defaultColorHex = "#808080"

    @Attribute(.unique) var id: UUID
    var name: String
    private var colorHexRaw: String

    var colorHex: String {
        get {
            // Regex to check if colorHexRaw is a valid hex color string
            let hexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
            let isHex = colorHexRaw.range(of: hexPattern, options: .regularExpression) != nil
            return isHex ? colorHexRaw : Tag.defaultColorHex
        }
        set {
            colorHexRaw = newValue
        }
    }
    
    // Relationships
    var notes: [Note]?
    var tasks: [Task]?
    @Relationship(inverse: \ZoteroReference.tags)
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = Tag.defaultColorHex) {
        self.id = id
        self.name = name
        self.colorHexRaw = colorHex
    }
}
