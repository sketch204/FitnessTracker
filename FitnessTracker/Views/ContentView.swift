import Business
import SwiftUI

struct ContentView: View {
    let store = ExerciseStore()
    
    var body: some View {
        NavigationStack {
            ExerciseListView(store: store)
        }
    }
}

#Preview {
    ContentView()
}
