import Foundation
import SwiftData

// Core schema for Tag
@Model
final class Tag {
    var id: UUID = UUID()
    var name: String = ""

    internal var colorHexRaw: String = "#808080"

    static let defaultColorHex = "#808080"
    static let colorHexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
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
    @Relationship(inverse: \Note.tags)
    var notes: [Note]?

    @Relationship(inverse: \Task.tags)
    var tasks: [Task]?

    @Relationship(inverse: \ZoteroReference.tags)
    var references: [ZoteroReference]?

    @Relationship(inverse: \TimeBlock.tags)
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHexRaw = colorHex // Initializer, validate manually if needed, but going through setter or direct assignment is fine
        // Let's actually use the property setter for validation
        self.colorHex = colorHex
    }
}
