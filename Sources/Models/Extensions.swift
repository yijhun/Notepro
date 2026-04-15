import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        if count == 0 { return [] }
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBufferPointer { buffer in
            self.copyBytes(to: buffer)
        }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        var result = Data()
        self.withUnsafeBufferPointer { buffer in
            result = Data(buffer: buffer)
        }
        return result
    }
}
