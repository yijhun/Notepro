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
            if newValue.range(of: "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", options: .regularExpression) != nil {
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
    
    init(id: UUID = UUID(), name: String, colorHex: String = Tag.defaultColorHex) {
        self.id = id
        self.name = name

        if colorHex.range(of: "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", options: .regularExpression) != nil {
            self.colorHexRaw = colorHex
        } else {
            self.colorHexRaw = Tag.defaultColorHex
        }
    }
}
