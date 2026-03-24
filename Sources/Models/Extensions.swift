import Foundation

extension Data {
    /// Converts Data to an Array of Float safely.
    /// Uses `copyBytes(to:)` instead of `bindMemory` to prevent runtime memory alignment crashes on ARM devices.
    func toFloatArray() -> [Float] {
        var array = [Float](repeating: 0, count: self.count / MemoryLayout<Float>.stride)
        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return array
    }
}

extension Array where Element == Float {
    /// Converts an Array of Float to Data.
    func toData() -> Data {
        var copy = self
        return Data(bytes: &copy, count: copy.count * MemoryLayout<Float>.stride)
    }
}
