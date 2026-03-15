import Foundation

extension Data {
    func toFloatArray() -> [Float] {
        var array = [Float](repeating: 0.0, count: self.count / MemoryLayout<Float>.stride)
        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        var mutableSelf = self
        return Data(bytes: &mutableSelf, count: mutableSelf.count * MemoryLayout<Float>.stride)
    }
}
