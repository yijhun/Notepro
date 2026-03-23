import Foundation

extension Data {
    func toFloatArray() -> [Float]? {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return nil }
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return array
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        var copy = self
        return Data(bytes: &copy, count: self.count * MemoryLayout<Float>.stride)
    }
}
