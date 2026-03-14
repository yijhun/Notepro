import Foundation

extension Data {
    /// Converts a Data object storing Floats into an array of Floats.
    /// Crucially uses `copyBytes(to:)` instead of `bindMemory` to prevent runtime memory alignment crashes on ARM devices.
    func toFloatArray() -> [Float] {
        var floats = [Float](repeating: 0, count: self.count / MemoryLayout<Float>.size)
        _ = floats.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return floats
    }
}

extension Array where Element == Float {
    /// Converts an array of Floats into a Data object to optimize storage for vector search embeddings.
    func toData() -> Data {
        return self.withUnsafeBufferPointer { Data(buffer: $0) }
    }
}
