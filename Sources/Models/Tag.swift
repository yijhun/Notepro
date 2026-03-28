import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    private var colorHexRaw: String
    
    var colorHex: String {
        get {
            let regex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: colorHexRaw) ? colorHexRaw : "#808080"
        }
        set {
            colorHexRaw = newValue
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
        self.colorHexRaw = colorHex
    }
}
