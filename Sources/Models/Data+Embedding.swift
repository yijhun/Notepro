import Foundation

extension Data {
    /// Converts vector Data to an array of Floats.
    /// Uses copyBytes(to:) to prevent runtime memory alignment crashes on ARM devices.
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return [] }
        var array = [Float](repeating: 0, count: count)
        self.copyBytes(to: &array, count: self.count)
        return array
    }
}

extension Array where Element == Float {
    /// Converts an array of Floats to Data.
    func toData() -> Data {
        self.withUnsafeBufferPointer { buffer in
            return Data(buffer: buffer)
        }
    }
}
