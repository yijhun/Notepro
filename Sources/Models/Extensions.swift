import Foundation

extension Data {
    func toFloatArray() -> [Float]? {
        guard self.count % MemoryLayout<Float>.stride == 0 else { return nil }
        var array = [Float](repeating: 0, count: self.count / MemoryLayout<Float>.stride)
        _ = array.withUnsafeMutableBufferPointer { buffer in
            self.copyBytes(to: buffer)
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
