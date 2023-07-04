import SwiftUI

struct JournalEntryView: View {
    @State private var entryText = ""
    @StateObject private var entryViewModel = JournalEntryViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("New journal entry:")
                    TextEditor(text: $entryText)
                        .frame(minHeight: 150)
                }
                
                Section {
                    Button(action: {
                        let entry = JournalEntry(id: nil, userId: 1, content: entryText)
                        entryViewModel.add(entry)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
            }
            .navigationTitle("New Journal Entry")
        }
    }
}

class JournalEntryViewModel: ObservableObject {
    @Published var entries = [JournalEntry]()
    
    func add(_ entry: JournalEntry) {
        // Perform API call or database operation to save the entry
        // After the entry is saved, add it to the entries array
        entries.append(entry)
    }
}
