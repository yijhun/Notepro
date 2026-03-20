import Foundation

extension Array where Element == Float {
    /// Converts an array of Float to Data.
    func toData() -> Data {
        return self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}

extension Data {
    /// Converts Data to an array of Float.
    /// Crucially uses `copyBytes(to:)` instead of `bindMemory` to prevent runtime memory alignment crashes on ARM devices.
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.size
        guard count > 0 else { return [] }
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBytes { ptr in
            self.copyBytes(to: ptr)
        }
        return array
    }
}
