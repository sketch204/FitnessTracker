import Business

extension Exercise: Equatable {
    public static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.description == rhs.description
    }
}
