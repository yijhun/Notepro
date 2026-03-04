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

extension Embeddable {
    var embeddingArray: [Float]? {
        get {
            return embedding?.toFloatArray()
        }
        set {
            embedding = newValue?.toData()
        }
    }
}

extension Data {
    func toFloatArray() -> [Float] {
        guard self.count % MemoryLayout<Float>.stride == 0 else { return [] }
        let count = self.count / MemoryLayout<Float>.stride
        var array = [Float](repeating: 0, count: count)
        array.withUnsafeMutableBytes { pointer in
            _ = self.copyBytes(to: pointer)
        }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        return self.withUnsafeBufferPointer { pointer in
            Data(buffer: pointer)
        }
    }
}
