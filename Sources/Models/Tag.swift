import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    
    var colorHexRaw: String
    var colorHex: String {
        get { colorHexRaw }
        set {
            if Self.isValidHex(newValue) {
                colorHexRaw = newValue
            } else {
                colorHexRaw = Self.defaultColorHex
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
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        if Self.isValidHex(colorHex) {
            self.colorHexRaw = colorHex
        } else {
            self.colorHexRaw = Self.defaultColorHex
        }
    }
}
