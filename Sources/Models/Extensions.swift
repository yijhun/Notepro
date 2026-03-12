import Foundation

extension Array where Element == Float {
    func toData() -> Data {
        return self.withUnsafeBufferPointer { buffer in
            return Data(buffer: buffer)
        }
    }
}

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.size
        var array = [Float](repeating: 0, count: count)
        array.withUnsafeMutableBytes { buffer in
            self.copyBytes(to: buffer)
        }
        return array
    }
}
