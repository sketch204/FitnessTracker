import Business
import SwiftUI

struct ExerciseListView: View {
    let store: ExerciseStore
    
    @State private var isAddingExercise: Bool = false
    
    @State private var isProposingDeletion: Bool = false
    @State private var proposedExerciseIdDeletion: Exercise.ID?
    
    var body: some View {
        List {
            ForEach(store.exercises) { exercise in
                ExerciseRow(exercise)
                    .swipeActions(allowsFullSwipe: false) {
                        Button("Delete") {
                            proposedExerciseIdDeletion = exercise.id
                            isProposingDeletion = true
                        }
                        .tint(.red)
                    }
            }
        }
        .navigationTitle("Exercises")
        .toolbar {
            Button {
                isAddingExercise = true
            } label: {
                Label("Add Exercise", systemImage: "plus")
            }
        }
        .sheet(isPresented: $isAddingExercise) {
            NavigationStack {
                EditExerciseView(store: store)
            }
        }
        .confirmationDialog(
            "Are you sure you want to delete this exercise?",
            isPresented: $isProposingDeletion,
            presenting: proposedExerciseIdDeletion) { id in
                Button("Cancel", role: .cancel) {
                    proposedExerciseIdDeletion = nil
                }
                
                Button("Delete", role: .destructive) {
                    store.removeExercise(id: id)
                    proposedExerciseIdDeletion = nil
                }
            } message: { _ in
                Text("This action cannot be undone")
            }

    }
}

#Preview {
    NavigationStack {
        ExerciseListView(store: .preview())
    }
}
