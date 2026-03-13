import Foundation

extension Data {
    /// Converts Data to an array of Floats using `copyBytes(to:)` to prevent alignment crashes
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return [] }

        var array = [Float](repeating: 0.0, count: count)
        _ = array.withUnsafeMutableBytes { buffer in
            self.copyBytes(to: buffer)
        }
        return array
    }
}

extension Array where Element == Float {
    /// Converts an array of Floats to Data
    func toData() -> Data {
        self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}
