import XCTest
@testable import Business

final class ExerciseStorePersistenceTests: XCTestCase {
    var sut: ExerciseStore!
    private let persistenceManager = MockPersistenceManager()
    
    override func setUp() async throws {
        sut = ExerciseStore(persistenceManager: persistenceManager)
        
        try? await Task.sleep(for: .milliseconds(100))
    }
    
    func test_init_callsLoadExercises() {
        XCTAssertEqual(persistenceManager.loadExercisesCalls.count, 1)
    }
    
    func test_addExercise_callsSaveExercises() {
        let exercise = testExercise1
        sut.addExercise(exercise)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 1)
        let savedExercises = persistenceManager.saveExercisesCalls.first?.exercises
        XCTAssertEqual(savedExercises?.count, 1)
        XCTAssertEqual(savedExercises?.first, exercise)
    }
    
    func test_addExercises_callsSaveExercises() {
        let exercisesToAdd = [
            testExercise1,
            testExercise2,
        ]
        
        sut.addExercises(exercisesToAdd)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 1)
        let savedExercises = persistenceManager.saveExercisesCalls.first?.exercises
        XCTAssertEqual(savedExercises?.count, 2)
        XCTAssertEqual(savedExercises, exercisesToAdd)
    }
    
    func test_removeExerciseById_callsSaveExercises() {
        let exerciseToRemove = testExercise1
        sut.addExercise(exerciseToRemove)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 1)
        
        sut.removeExercise(id: exerciseToRemove.id)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 2)
        let savedExercises = persistenceManager.saveExercisesCalls.last?.exercises
        XCTAssertEqual(savedExercises, [])
    }
    
    func test_removeExerciseByIndex_cSaveExercises() {
        let exercises = [
            testExercise1,
            testExercise2,
        ]
        
        sut.addExercises(exercises)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 1)
        
        let indexToRemove = 0
        sut.removeExercise(at: indexToRemove)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 2)
        let savedExercises = persistenceManager.saveExercisesCalls.last?.exercises
        XCTAssertEqual(savedExercises, [testExercise2])
    }
    
    func test_moveExercises_callsSaveExercises() {
        let exercises = [
            testExercise1,
            testExercise2,
            testExercise3,
        ]
        
        sut.addExercises(exercises)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 1)
        
        let indexSetToMove = IndexSet(integer: 0)
        let destinationIndex = 2
        sut.moveExercises(at: indexSetToMove, to: destinationIndex)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 2)
        let savedExercises = persistenceManager.saveExercisesCalls.last?.exercises
        XCTAssertEqual(savedExercises, [testExercise2, testExercise3, testExercise1])
    }
    
    func testUpdateExerciseCallsSaveExercises() {
        let originalExercise = testExercise1
        sut.addExercise(originalExercise)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 1)
        
        let updatedExercise = Exercise(id: originalExercise.id.rawValue, name: "Pilates", description: "Core strength exercise")
        sut.updateExercise(id: originalExercise.id, updatedExercise)
        
        XCTAssertEqual(persistenceManager.saveExercisesCalls.count, 2)
        let savedExercises = persistenceManager.saveExercisesCalls.last?.exercises
        XCTAssertEqual(savedExercises, [updatedExercise])
    }
}

private final class MockPersistenceManager: ExerciseStorePersistenceManager {
    var loadExercisesCalls: [() -> Void] = []
    var saveExercisesCalls: [(exercises: [Exercise], completion: () -> Void)] = []
    
    func loadExercises() async -> [Exercise] {
        loadExercisesCalls.append({ })
        return []
    }
    
    func saveExercises(_ exercises: [Exercise]) {
        saveExercisesCalls.append((exercises: exercises, completion: { }))
    }
}
