import Foundation

extension Data {
    func toFloatArray() -> [Float]? {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return nil }
        var array = [Float](repeating: 0, count: count)
        array.withUnsafeMutableBufferPointer { buffer in
            _ = self.copyBytes(to: buffer)
        }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data? {
        guard !self.isEmpty else { return nil }
        return self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}
