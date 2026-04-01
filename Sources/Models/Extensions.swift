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
        var data = Data()
        _ = self.withUnsafeBufferPointer { buffer in
            data = Data(buffer: buffer)
        }
        return data
    }
}
