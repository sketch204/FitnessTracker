import Foundation

@Observable
public final class ExerciseStore {
    public private(set) var exercises: [Exercise]
    
    public init(exercises: [Exercise] = []) {
        self.exercises = exercises
    }
}

extension ExerciseStore {
    public func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
    
    public func addExercises(_ exercises: some Sequence<Exercise>) {
        self.exercises.append(contentsOf: exercises)
    }
    
    public func removeExercise(id: Exercise.ID) {
        exercises.removeAll(where: { $0.id == id })
    }
    
    public func removeExercise(at index: Int) {
        guard exercises.indices.contains(index) else { return }
        exercises.remove(at: index)
    }
    
    public func moveExercises(at indexSet: IndexSet, to destination: Int) {
        guard exercises.indices.contains(indexSet) else { return }
        
        let movedExercises = indexSet.map({ exercises.remove(at: $0) })
        
        if !exercises.indices.contains(destination) {
            exercises.append(contentsOf: movedExercises)
        } else {
            exercises.insert(contentsOf: movedExercises, at: destination)
        }
    }
    
    public func updateExercise(id: Exercise.ID, _ newValue: Exercise) {
        guard let index = exercises.firstIndex(where: { $0.id == id }) else { return }
        exercises[index] = newValue
    }
}
