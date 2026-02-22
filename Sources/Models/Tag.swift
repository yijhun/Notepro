import Foundation
import SwiftData

/// A tag that can be applied to Notes, Tasks, TimeBlocks, and References.
@Model
public final class Tag {
    @Attribute(.unique) public var id: UUID
    public var name: String
    public var colorHex: String
    
    // Relationships
    public var notes: [Note]?
    public var tasks: [Task]?
    public var references: [ZoteroReference]?
    public var timeBlocks: [TimeBlock]?
    
    public init(id: UUID = UUID(), name: String, colorHex: String = "#808080") {
        self.id = id
        self.name = name
        self.colorHex = colorHex
    }
}
