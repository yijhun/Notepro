import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String

    // Fallback default color
    static let defaultColorHex = "#808080"

    // Cached regex for hex color validation
    static let colorHexPattern = try! NSRegularExpression(pattern: "^#(?:[0-9a-fA-F]{3}){1,2}$")

    var colorHexRaw: String

    var colorHex: String {
        get { colorHexRaw }
        set {
            let range = NSRange(location: 0, length: newValue.utf16.count)
            if Tag.colorHexPattern.firstMatch(in: newValue, options: [], range: range) != nil {
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
    
    init(id: UUID = UUID(), name: String, colorHex: String = defaultColorHex) {
        self.id = id
        self.name = name

        let range = NSRange(location: 0, length: colorHex.utf16.count)
        if Tag.colorHexPattern.firstMatch(in: colorHex, options: [], range: range) != nil {
            self.colorHexRaw = colorHex
        } else {
            self.colorHexRaw = Tag.defaultColorHex
        }
    }
}
