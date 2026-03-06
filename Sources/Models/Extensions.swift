import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        if count == 0 { return [] }
        var array = [Float](repeating: 0, count: count)
        array.withUnsafeMutableBytes { buffer in
            _ = self.copyBytes(to: buffer)
        }
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
