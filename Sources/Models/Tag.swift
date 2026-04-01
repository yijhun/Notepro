import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    private var colorHexRaw: String

    static let defaultColorHex = "#808080"

    var colorHex: String {
        get { colorHexRaw }
        set {
            if isValidHex(newValue) {
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
        // Initialize with default temporarily
        self.colorHexRaw = Tag.defaultColorHex
        // Use the property setter logic manually for initialization
        if self.isValidHex(colorHex) {
            self.colorHexRaw = colorHex
        }
    }

    private func isValidHex(_ hex: String) -> Bool {
        let regex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
        return hex.range(of: regex, options: .regularExpression) != nil
    }
}
