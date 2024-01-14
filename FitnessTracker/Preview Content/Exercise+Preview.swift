import Business
import Foundation

extension Exercise {
    static let preview = Self(id: UUID(), name: "Push-ups", description: "Upper body exercise")
    static let preview2 = Self(id: UUID(), name: "Squats", description: "Upper legs exercise")
    static let preview3 = Self(id: UUID(), name: "Bench Press", description: "Upper body exercise")
    static let preview4 = Self(id: UUID(), name: "Seated Bicep Curls", description: "Bicep exercise")
    
    static let previews: [Self] = [.preview, .preview2, .preview3, .preview4]
}
