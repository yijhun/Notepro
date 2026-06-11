import Foundation
import SwiftData

@Model // Core schema for Tag
final class Tag {
    var id: UUID = UUID()
    var name: String = ""
    internal var colorHexRaw: String = "#808080"

    static let defaultColorHex: String = "#808080"
    static let colorHexPattern: String = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    static let colorHexRegex = try! NSRegularExpression(pattern: colorHexPattern)

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
    
    init(id: UUID = UUID(), name: String = "", colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHexRaw = colorHex // Initialize raw backing property first
        self.colorHex = colorHex // Then trigger validation
    }
}
