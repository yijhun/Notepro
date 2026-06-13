import Foundation
import SwiftData

@Model
final class Tag { // Core schema for Tag
    var id: UUID = UUID()
    var name: String = ""

    static let colorHexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    static let colorHexRegex = try! NSRegularExpression(pattern: colorHexPattern)
    static let defaultColorHex = "#808080"

    var colorHexRaw: String = "#808080"

    var colorHex: String {
        get { colorHexRaw }
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
        self.colorHexRaw = colorHex // Init the backing property directly first
        self.colorHex = colorHex
    }
}
