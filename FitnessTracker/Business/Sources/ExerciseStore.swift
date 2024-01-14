import Foundation

public protocol ExerciseStorePersistenceManager {
    func loadExercises() async -> [Exercise]
    func saveExercises(_ exercises: [Exercise])
}

@Observable
public final class ExerciseStore {
    public private(set) var exercises: [Exercise]
    private let persistenceManager: ExerciseStorePersistenceManager?
    
    public init(persistenceManager: ExerciseStorePersistenceManager) {
        self.exercises = []
        self.persistenceManager = persistenceManager
        
        Task {
            self.exercises = await persistenceManager.loadExercises()
        }
    }
    
    public init(exercises: [Exercise] = []) {
        self.exercises = exercises
        self.persistenceManager = nil
    }
}

extension ExerciseStore {
    private func saveExercises() {
        persistenceManager?.saveExercises(exercises)
    }
}

extension ExerciseStore {
    public func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
        saveExercises()
    }
    
    public func addExercises(_ exercises: some Sequence<Exercise>) {
        self.exercises.append(contentsOf: exercises)
        saveExercises()
    }
    
    public func removeExercise(id: Exercise.ID) {
        exercises.removeAll(where: { $0.id == id })
        saveExercises()
    }
    
    public func removeExercise(at index: Int) {
        guard exercises.indices.contains(index) else { return }
        exercises.remove(at: index)
        saveExercises()
    }
    
    public func moveExercises(at indexSet: IndexSet, to destination: Int) {
        guard exercises.indices.contains(indexSet) else { return }
        
        let movedExercises = indexSet.map({ exercises.remove(at: $0) })
        
        if !exercises.indices.contains(destination) {
            exercises.append(contentsOf: movedExercises)
        } else {
            exercises.insert(contentsOf: movedExercises, at: destination)
        }
        saveExercises()
    }
    
    public func updateExercise(id: Exercise.ID, _ newValue: Exercise) {
        guard let index = exercises.firstIndex(where: { $0.id == id }) else { return }
        exercises[index] = newValue
        saveExercises()
    }
}
