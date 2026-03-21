import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBytes { bytes in
            self.copyBytes(to: bytes)
        }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        var data = Data(count: self.count * MemoryLayout<Float>.stride)
        _ = data.withUnsafeMutableBytes { bytes in
            self.withUnsafeBytes { buffer in
                bytes.copyMemory(from: buffer)
            }
        }
        return data
    }
}
