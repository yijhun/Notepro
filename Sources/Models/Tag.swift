import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    var colorHex: String {
        didSet {
            if !Tag.isValidHexColor(colorHex) {
                colorHex = oldValue
            }
        }
    }

    static func isValidHexColor(_ hex: String) -> Bool {
        let hexRegex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
        let hexPredicate = NSPredicate(format: "SELF MATCHES %@", hexRegex)
        return hexPredicate.evaluate(with: hex)
    }
    
    // Relationships
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHex = Tag.isValidHexColor(colorHex) ? colorHex : "#808080"
    }
}
