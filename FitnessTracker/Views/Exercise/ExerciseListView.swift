import Business
import SwiftUI

struct ExerciseListView: View {
    let store: ExerciseStore
    
    @State private var isAddingExercise: Bool = false
    
    var body: some View {
        List {
            ForEach(store.exercises) { exercise in
                ExerciseRow(exercise)
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
    }
}

#Preview {
    NavigationStack {
        ExerciseListView(store: .preview())
    }
}
