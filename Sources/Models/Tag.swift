import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var id: UUID
    var name: String

    private var colorHexRaw: String

    var colorHex: String {
        get { colorHexRaw }
        set {
            let regex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
            if newValue.range(of: regex, options: .regularExpression) != nil {
                colorHexRaw = newValue
            } else {
                colorHexRaw = Tag.defaultColorHex
            }
        }
    }

    static let defaultColorHex = "#808080"
    
    // Relationships
    var notes: [Note]?
    var tasks: [Task]?
    var references: [ZoteroReference]?
    var timeBlocks: [TimeBlock]?
    
    init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name

        let regex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
        if colorHex.range(of: regex, options: .regularExpression) != nil {
            self.colorHexRaw = colorHex
        } else {
            self.colorHexRaw = Tag.defaultColorHex
        }
    }
}
