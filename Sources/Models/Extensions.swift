import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        var array = [Float](repeating: 0.0, count: self.count / MemoryLayout<Float>.size)
        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        return self.withUnsafeBufferPointer { Data(buffer: $0) }
    }
}
