import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return [] }
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBufferPointer { buffer in
            self.copyBytes(to: buffer)
        }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        guard !self.isEmpty else { return Data() }
        var data = Data()
        _ = self.withUnsafeBufferPointer { buffer in
            data = Data(buffer: buffer)
        }
        return data
    }
}
