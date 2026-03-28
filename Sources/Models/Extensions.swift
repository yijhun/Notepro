import Foundation

extension Data {
    func toFloatArray() -> [Float]? {
        let count = self.count / MemoryLayout<Float>.size
        if count == 0 { return nil }

        var array = [Float](repeating: 0, count: count)
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
