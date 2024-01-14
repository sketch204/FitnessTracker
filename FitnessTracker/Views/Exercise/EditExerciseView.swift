import Business
import SwiftUI

struct EditExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    
    let store: ExerciseStore
    
    private let exerciseId: Exercise.ID?
    @State private var name: String = ""
    @State private var description: String = ""
    
    private var isCreating: Bool { exerciseId == nil }
    private var canFinishEditing: Bool {
        !name.isEmpty
    }
    
    init(exercise: Exercise? = nil, store: ExerciseStore) {
        self.store = store
        self.exerciseId = exercise?.id
        _name = State(wrappedValue: exercise?.name ?? "")
        _description = State(wrappedValue: exercise?.description ?? "")
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Description", text: $description)
        }
        .navigationTitle(isCreating ? "Add Exercise" : "Update Exercise")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(isCreating ? "Add" : "Update", action: finishEditing)
                    .disabled(!canFinishEditing)
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", action: cancelEditing)
            }
        }
    }
    
    private func finishEditing() {
        let description = description.isEmpty ? nil : description
        
        if let exerciseId {
            store.updateExercise(
                id: exerciseId,
                Exercise(
                    id: exerciseId.rawValue,
                    name: name,
                    description: description
                )
            )
        } else {
            store.addExercise(
                Exercise(
                    id: UUID(),
                    name: name,
                    description: description
                )
            )
        }
        dismiss()
    }
    
    private func cancelEditing() {
        dismiss()
    }
}

#Preview {
    NavigationStack {
        EditExerciseView(store: .preview())
    }
}
