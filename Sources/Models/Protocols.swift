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
    /// Converts Data back to a Float array safely, avoiding memory alignment issues on ARM.
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        if count == 0 { return [] }
        var array = [Float](repeating: 0, count: count)
        array.withUnsafeMutableBytes { buffer in
            self.copyBytes(to: buffer)
        }
        return array
    }
}

extension Array where Element == Float {
    /// Converts a Float array to Data for storage.
    func toData() -> Data {
        self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}
