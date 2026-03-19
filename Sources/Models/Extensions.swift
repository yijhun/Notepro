import Foundation

public extension Data {
    func toFloatArray() -> [Float] {
        let count = self.count / MemoryLayout<Float>.stride
        guard count > 0 else { return [] }
        var array = [Float](repeating: 0, count: count)
        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
        return array
    }
}

public extension Array where Element == Float {
    func toData() -> Data {
        var mutableSelf = self
        var data = Data()
        _ = mutableSelf.withUnsafeMutableBytes { buffer in
            data = Data(buffer.bindMemory(to: UInt8.self))
        }
        return data
    }
}
