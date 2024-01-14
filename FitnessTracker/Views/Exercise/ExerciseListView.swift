import Business
import SwiftUI

struct ExerciseListView: View {
    let store: ExerciseStore
    
    @State private var isAddingExercise: Bool = false
    
    @State private var proposedExerciseEdit: Exercise?
    
    @State private var isProposingDeletion: Bool = false
    @State private var proposedExerciseIdDeletion: Exercise.ID?
    
    var body: some View {
        List {
            ForEach(store.exercises) { exercise in
                ExerciseRow(exercise)
                    .contextMenu {
                        editExerciseButton(exercise)
                        deleteExerciseButton(exercise)
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Group {
                            deleteExerciseButton(exercise, setRole: false)
                            editExerciseButton(exercise)
                        }
                        .labelStyle(.titleOnly)
                    }
            }
        }
        .overlay {
            if store.exercises.isEmpty {
                noExercisesView
            }
        }
        .animation(.default, value: store.exercises)
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
        .sheet(item: $proposedExerciseEdit) { exercise in
            NavigationStack {
                EditExerciseView(exercise: exercise, store: store)
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
    
    private func deleteExerciseButton(_ exercise: Exercise, setRole: Bool = true) -> some View {
        Button(role: setRole ? .destructive : nil) {
            proposedExerciseIdDeletion = exercise.id
            isProposingDeletion = true
        } label: {
            Label("Delete", systemImage: "trash")
        }
        .tint(.red)
    }
    
    private func editExerciseButton(_ exercise: Exercise) -> some View {
        Button {
            proposedExerciseEdit = exercise
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
    
    private var noExercisesView: some View {
        ContentUnavailableView {
            Label("No Exercises", systemImage: "figure.run.square.stack.fill")
        } description: {
            Text("Begin by creating an exercise")
        } actions: {
            Button("Create Exercise") {
                isAddingExercise = true
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NavigationStack {
        ExerciseListView(store: .preview())
    }
}
