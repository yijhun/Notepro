import Foundation

extension Array where Element == Float {
    func toData() -> Data {
        self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return [] }
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBytes { buffer in
            self.copyBytes(to: buffer)
        }
        return array
    }
}
