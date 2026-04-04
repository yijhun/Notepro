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
            // Regex to validate either #RGB or #RRGGBB (case insensitive)
            let pattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: colorHexRaw.utf16.count)
            if regex?.firstMatch(in: colorHexRaw, options: [], range: range) != nil {
                return colorHexRaw
            } else {
                return Tag.defaultColorHex
            }
        }
        set {
            colorHexRaw = newValue
        }
    }
    
    // Relationships
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = Tag.defaultColorHex) {
        self.id = id
        self.name = name
        self.colorHexRaw = colorHex
    }
}
