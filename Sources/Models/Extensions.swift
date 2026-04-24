import Foundation

extension Array where Element == Float {
    /// Converts an array of Floats into Data for storage.
    func toData() -> Data {
        self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}

extension Data {
    /// Converts Data back into an array of Floats.
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        var array = [Float](repeating: 0, count: count)
        array.withUnsafeMutableBufferPointer { buffer in
            _ = self.copyBytes(to: buffer)
        }
        return array
    }
}
