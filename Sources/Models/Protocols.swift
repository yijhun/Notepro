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
            embedding?.toFloatArray()
        }
        set {
            embedding = newValue?.toData()
        }
    }
}

extension Data {
    func toFloatArray() -> [Float]? {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return nil }
        var array = [Float](repeating: 0.0, count: count)
        self.copyBytes(to: &array, count: self.count)
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        return self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}
