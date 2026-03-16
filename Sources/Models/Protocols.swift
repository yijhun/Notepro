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
    var embedding: [Float]? { get set }
}

extension Array where Element == Float {
    func toData() -> Data {
        let array = self
        return Data(bytes: array, count: array.count * MemoryLayout<Float>.stride)
    }
}

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBytes {
            self.copyBytes(to: $0)
        }
        return array
    }
}
