import Business
import Foundation

extension ExerciseStore {
    static func preview(exercise: [Exercise] = Exercise.previews) -> Self {
        Self(exercises: exercise)
    }
}
