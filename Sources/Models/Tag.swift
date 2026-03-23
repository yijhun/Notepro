import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    var colorHex: String {
        didSet {
            if !Self.isValidHexColor(colorHex) {
                colorHex = oldValue
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
        self.colorHex = Self.isValidHexColor(colorHex) ? colorHex : "#808080"
    }

    static func isValidHexColor(_ hex: String) -> Bool {
        let pattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
        return hex.range(of: pattern, options: .regularExpression) != nil
    }
}
