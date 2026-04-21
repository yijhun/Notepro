import Foundation
import SwiftData

@Model // Core schema for Tag
final class Tag {
    var id: UUID = UUID()
    var name: String = ""
    var colorHexRaw: String = "#808080"

    static let defaultColorHex = "#808080"
    static let colorHexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    static let colorHexRegex = try! NSRegularExpression(pattern: colorHexPattern, options: [])

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
    var notes: [Note]? = nil
    var tasks: [Task]? = nil
    var references: [ZoteroReference]? = nil
    var timeBlocks: [TimeBlock]? = nil
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name

        let range = NSRange(location: 0, length: colorHex.utf16.count)
        if Tag.colorHexRegex.firstMatch(in: colorHex, options: [], range: range) != nil {
            self.colorHexRaw = colorHex
        } else {
            self.colorHexRaw = Tag.defaultColorHex
        }
    }
}
