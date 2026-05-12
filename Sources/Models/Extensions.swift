import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        var floats = [Float](repeating: 0, count: self.count / MemoryLayout<Float>.stride)
        _ = floats.withUnsafeMutableBufferPointer { buffer in
            self.copyBytes(to: buffer)
        }
        return floats
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        return self.withUnsafeBufferPointer { buffer in
            return Data(buffer: buffer)
        }
    }
}
