import Foundation

/// Protocol for items that can be tagged
protocol Taggable {
    var tags: [Tag]? { get set }
}

/// Protocol for items that can have associated time blocks (events)
protocol TimeBlockable {
    var timeBlocks: [TimeBlock]? { get set }
}

/// Protocol for items that support vector embeddings for semantic search
protocol Embeddable: AnyObject {
    var embedding: Data? { get set }
}

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.size
        guard count > 0 else { return [] }
        var array = [Float](repeating: 0, count: count)
        self.copyBytes(to: &array, count: self.count)
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        return self.withUnsafeBufferPointer { Data(buffer: $0) }
    }
}
