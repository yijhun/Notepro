import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        var array = [Float](repeating: 0.0, count: self.count / MemoryLayout<Float>.stride)
        _ = array.withUnsafeMutableBufferPointer { buffer in
            self.copyBytes(to: buffer)
        }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        self.withUnsafeBufferPointer { buffer in
            Data(buffer: buffer)
        }
    }
}
