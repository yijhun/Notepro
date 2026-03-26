import Foundation

extension Data {
    func toFloatArray() -> [Float]? {
        guard self.count % MemoryLayout<Float>.stride == 0 else { return nil }
        var floats = [Float](repeating: 0, count: self.count / MemoryLayout<Float>.stride)
        _ = floats.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return floats
    }
}

extension Array where Element == Float {
    func toData() -> Data {
        var mutableSelf = self
        var data = Data()
        _ = mutableSelf.withUnsafeMutableBytes { buffer in
            data.append(contentsOf: buffer)
        }
        return data
    }
}
