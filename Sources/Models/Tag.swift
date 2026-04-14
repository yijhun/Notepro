import Foundation
import SwiftData

@Model
final class Tag {
    static let defaultColorHex = "#808080"
    static let colorHexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    static let colorHexRegex = try! NSRegularExpression(pattern: colorHexPattern)

    @Attribute(.unique) var id: UUID
    var name: String
    var colorHexRaw: String

    var colorHex: String {
        get {
            let range = NSRange(location: 0, length: colorHexRaw.utf16.count)
            if Tag.colorHexRegex.firstMatch(in: colorHexRaw, options: [], range: range) != nil {
                return colorHexRaw
            } else {
                return Tag.defaultColorHex
            }
        }
        set {
            let range = NSRange(location: 0, length: newValue.utf16.count)
            if Tag.colorHexRegex.firstMatch(in: newValue, options: [], range: range) != nil {
                colorHexRaw = newValue
            } else {
                colorHexRaw = Tag.defaultColorHex
            }
        }
    }
    
    // Relationships
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHexRaw = colorHex
    }
}
