import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String
    internal var colorHexRaw: String

    static let defaultColorHex = "#808080"
    static let colorHexPattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"

    var colorHex: String {
        get {
            let predicate = NSPredicate(format: "SELF MATCHES %@", Tag.colorHexPattern)
            return predicate.evaluate(with: colorHexRaw) ? colorHexRaw : Tag.defaultColorHex
        }
        set {
            let predicate = NSPredicate(format: "SELF MATCHES %@", Tag.colorHexPattern)
            colorHexRaw = predicate.evaluate(with: newValue) ? newValue : Tag.defaultColorHex
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

        let predicate = NSPredicate(format: "SELF MATCHES %@", Tag.colorHexPattern)
        self.colorHexRaw = predicate.evaluate(with: colorHex) ? colorHex : Tag.defaultColorHex
    }
}
