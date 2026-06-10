import Foundation
import SwiftData

@Model // Core schema for Tag
final class Tag {
    var id: UUID = UUID()
    var name: String = ""
    internal var colorHexRaw: String = "#808080"

    var colorHex: String {
        get { colorHexRaw }
        set {
            if Tag.isValidHex(newValue) {
                colorHexRaw = newValue
            } else {
                colorHexRaw = Tag.defaultColorHex
            }
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
    var notes: [Note]? = nil
    var tasks: [Task]? = nil
    var references: [ZoteroReference]? = nil
    var timeBlocks: [TimeBlock]? = nil
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHexRaw = Tag.defaultColorHex
        self.colorHex = colorHex
    }
}
