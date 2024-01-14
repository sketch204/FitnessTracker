import Foundation

public struct Identifier<Parent, RawValue>: Hashable, RawRepresentable where RawValue: Hashable {
    public let rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension Identifier: Encodable where RawValue: Encodable {}
extension Identifier: Decodable where RawValue: Decodable {}
