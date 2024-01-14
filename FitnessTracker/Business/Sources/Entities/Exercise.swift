import Foundation

public struct Exercise: Equatable, Hashable, Identifiable {
    public let id: Identifier<Self, UUID>
    public let name: String
    public let description: String?
    
    public init(id: UUID, name: String, description: String?) {
        self.id = Identifier(rawValue: id)
        self.name = name
        self.description = description
    }
}
