import Business
import SwiftUI

struct ExerciseListView: View {
    let store: ExerciseStore
    
    var body: some View {
        List {
            ForEach(store.exercises) { exercise in
                ExerciseRow(exercise)
            }
        }
        .navigationTitle("Exercises")
    }
}

#Preview {
    NavigationStack {
        ExerciseListView(store: .preview())
    }
}
