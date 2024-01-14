import XCTest
@testable import Business

final class ExerciseStoreTests: XCTestCase {
    var sut: ExerciseStore!
    
    override func setUpWithError() throws {
        sut = ExerciseStore(exercises: [testExercise1, testExercise2])
    }
    
    func test_addExercise() {
        sut.addExercise(testExercise3)
        
        XCTAssertEqual(sut.exercises.count, 3)
        XCTAssertEqual(sut.exercises.last, testExercise3)
    }
    
    func test_removeExerciseById() {
        let exerciseIdToRemove = testExercise1.id
        sut.removeExercise(id: exerciseIdToRemove)
        
        XCTAssertEqual(sut.exercises.count, 1)
        XCTAssertFalse(sut.exercises.contains(where: { $0.id == exerciseIdToRemove }))
    }
    
    func test_removeExerciseById_removingNonExistentId() {
        let exerciseIdToRemove = testExercise3.id
        sut.removeExercise(id: exerciseIdToRemove)
        
        XCTAssertEqual(sut.exercises.count, 2)
        XCTAssertEqual(sut.exercises, [testExercise1, testExercise2])
    }
    
    func test_removeExerciseByIndex() {
        let indexToRemove = 1
        sut.removeExercise(at: indexToRemove)
        
        XCTAssertEqual(sut.exercises.count, 1)
        XCTAssertFalse(sut.exercises.contains(where: { $0.id == testExercise2.id }))
    }
    
    func test_removeExerciseByIndex_whenIndexOutOfBounds() {
        let indexToRemove = 4
        sut.removeExercise(at: indexToRemove)
        
        XCTAssertEqual(sut.exercises.count, 2)
        XCTAssertEqual(sut.exercises, [testExercise1, testExercise2])
    }
    
    func test_moveExercises() {
        sut.addExercise(testExercise3)
        
        let indexSetToMove = IndexSet(integer: 0)
        let destinationIndex = 2
        sut.moveExercises(at: indexSetToMove, to: destinationIndex)
        
        XCTAssertEqual(sut.exercises.count, 3)
        XCTAssertEqual(sut.exercises, [testExercise2, testExercise3, testExercise1])
    }
    
    func test_updateExercise() {
        let updatedExerciseId = testExercise1.id
        let updatedExercise = Exercise(id: updatedExerciseId.rawValue, name: "Pilates", description: "Core strength exercise")
        sut.updateExercise(id: updatedExerciseId, updatedExercise)
        
        XCTAssertEqual(sut.exercises.count, 2)
        XCTAssertEqual(sut.exercises, [updatedExercise, testExercise2])
    }
    
    func test_updateExercise_updatingNonExistentId() {
        let updatedExerciseId = testExercise3.id
        let updatedExercise = Exercise(id: updatedExerciseId.rawValue, name: "Pilates", description: "Core strength exercise")
        sut.updateExercise(id: updatedExerciseId, updatedExercise)
        
        XCTAssertEqual(sut.exercises.count, 2)
        XCTAssertEqual(sut.exercises, [testExercise1, testExercise2])
    }
}
