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
    /// Converts Data back to an array of Floats
    func toFloatArray() -> [Float] {
        var array = [Float](repeating: 0, count: self.count / MemoryLayout<Float>.stride)
        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return array
    }
}

extension Array where Element == Float {
    /// Converts an array of Floats to Data
    func toData() -> Data {
        return self.withUnsafeBufferPointer { Data(buffer: $0) }
    }
}
