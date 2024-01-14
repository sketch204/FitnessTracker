import Business
import SwiftUI

struct ExerciseRow: View {
    let exercise: Exercise
    
    init(_ exercise: Exercise) {
        self.exercise = exercise
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.name)
                .font(.headline)
            
            if let description = exercise.description, !description.isEmpty {
                Text(description)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    List {
        ExerciseRow(.preview)
        ExerciseRow(.preview2)
        ExerciseRow(
            Exercise(
                id: UUID(),
                name: "Super duper long long long name that goes on multiple lines",
                description: "Super duper long long long description that goes on multiple lines"
            )
        )
        ExerciseRow(
            Exercise(
                id: UUID(),
                name: "No description",
                description: nil
            )
        )
        ExerciseRow(
            Exercise(
                id: UUID(),
                name: "No description",
                description: ""
            )
        )
    }
}
