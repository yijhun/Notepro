import Foundation
import SwiftData

@Model // Core schema for Tag
final class Tag {
    var id: UUID = UUID()
    var name: String = ""
    internal var colorHexRaw: String = "#808080"

    var colorHex: String {
        get {
            Tag.isValidHex(colorHexRaw) ? colorHexRaw : Tag.defaultColorHex
        }
        set {
            colorHexRaw = Tag.isValidHex(newValue) ? newValue : Tag.defaultColorHex
        }
    }

    static let defaultColorHex = "#808080"
    static let colorHexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    static let colorHexRegex = try! NSRegularExpression(pattern: colorHexPattern)

    static func isValidHex(_ hex: String) -> Bool {
        let range = NSRange(location: 0, length: hex.utf16.count)
        return colorHexRegex.firstMatch(in: hex, options: [], range: range) != nil
    }
    
    // Relationships
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHexRaw = Tag.defaultColorHex
        self.colorHex = colorHex
    }
}
