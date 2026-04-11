import Foundation

extension Data {
    func toFloatArray() -> [Float]? {
        guard self.count % MemoryLayout<Float>.stride == 0 else { return nil }
        let count = self.count / MemoryLayout<Float>.stride
        var array = [Float](repeating: 0.0, count: count)
        _ = array.withUnsafeMutableBufferPointer { bufferPointer in
            self.copyBytes(to: bufferPointer)
        }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        return self.withUnsafeBufferPointer { bufferPointer in
            Data(buffer: bufferPointer)
        }
    }
}
