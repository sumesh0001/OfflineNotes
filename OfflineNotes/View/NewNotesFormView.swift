//
//  NewNotesFormView.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//

internal import SwiftUI
import SwiftData

struct NewNotesFormView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var selectedGenre: Priority = .low
    
    var noteToEdit: NotesModel?
    
    // MARK: - FUNCTIONS
    
    //    private func addNewMovie() {
    //      let newMovie = NotesModel(title: title, priority: selectedGenre)
    //      modelContext.insert(newMovie)
    //      title = ""
    //      selectedGenre = .low
    //    }
    
    
    private func saveNote() {
        if let existingNote = noteToEdit {
            // EDIT MODE
            existingNote.title = title
            existingNote.priority = selectedGenre
        } else {
            // CREATE MODE
            let newNote = NotesModel(title: title, priority: selectedGenre)
            modelContext.insert(newNote)
        }
    }
    var body: some View {
        Form {
            List {
                // MARK: - HEADER
                Text("What to Note")
                    .font(.largeTitle.weight(.black))
                    .foregroundStyle(.blue.gradient)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                
                // MARK: - TITLE
                TextField("Add note", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .font(.largeTitle.weight(.light))
                
                // MARK: - GENRE
                Picker("Priority", selection: $selectedGenre) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.name)
                            .tag(priority)
                    }
                }
                
                // MARK: - SAVE BUTTON
                Button {
                    if title.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        print("Input is invalid")
                        return
                    } else {
                        print("Valid input: \(title) - \(selectedGenre)")
                        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            return
                        }
                        
                        //              addNewMovie()
                        saveNote()
                        dismiss()
                    }
                } label: {
                    //            Text("Save")
                    Text(noteToEdit == nil ? "Save" : "Update")
                        .font(.title2.weight(.medium))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
                .glassEffect(.regular.interactive()) // TODO: - NEW CODE
                .padding(.bottom, 24) // TODO: - NEW CODE
                // .buttonBorderShape(.roundedRectangle) // TODO: - DELETE
                .disabled(title.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                // MARK: - CANCEL BUTTON
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                }
                
            } //: LIST
            .listRowSeparator(.hidden)
            .onAppear {   // 👈 RIGHT HERE
                if let note = noteToEdit {
                    title = note.title
                    selectedGenre = note.priority
                }
            }
        } //: FORM
    }
}

#Preview {
    NewNotesFormView()
}
