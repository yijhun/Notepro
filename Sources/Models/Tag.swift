import Foundation
import SwiftData

@Model
final class Tag {
    static let defaultColorHex = "#808080"
    static let colorHexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"

    @Attribute(.unique) var id: UUID
    var name: String

    var colorHexRaw: String

    var colorHex: String {
        get {
            guard colorHexRaw.range(of: Tag.colorHexPattern, options: .regularExpression) != nil else {
                return Tag.defaultColorHex
            }
            return colorHexRaw
        }
        set {
            if newValue.range(of: Tag.colorHexPattern, options: .regularExpression) != nil {
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

        if colorHex.range(of: Tag.colorHexPattern, options: .regularExpression) != nil {
            self.colorHexRaw = colorHex
        } else {
            self.colorHexRaw = Tag.defaultColorHex
        }
    }
}
