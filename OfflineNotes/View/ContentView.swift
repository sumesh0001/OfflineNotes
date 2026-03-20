//
//  ContentView.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//

internal import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.modelContext) var modelContext
    @Query private var notes: [NotesModel]
    
    @State private var isSheetPresented: Bool = false
    @State private var randomNotes: String = ""
    @State private var isShowingAlert: Bool = false
    
    @State private var searchText = ""
    
    @State private var selectedNote: NotesModel? = nil
    
    // MARK: - FUNCTIONS
    
    private func randomNotesGenerator() {
        randomNotes = notes.randomElement()!.title
    }
    
    //Filter data
    var filterNotes: [NotesModel] {
        if searchText.isEmpty{
            return notes
        }else{
            return notes.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                if !notes.isEmpty {
                    Section(
                        header:
                            VStack {
                                Text("List of Notes")
                                    .font(.largeTitle.weight(.black))
                                    .foregroundStyle(.blue.gradient)
                                    .padding()
                                
                                HStack {
                                    Label("Title", systemImage: "list.clipboard")
                                    Spacer()
                                    Label("Priority", systemImage: "tag")
                                }
                            }
                    ) {
                        ForEach(filterNotes) { note in
                            HStack {
                                Text(note.title)
                                    .font(.title.weight(.light))
                                    .padding(.vertical, 2)
                                
                                Spacer()
                                
                                Text(note.priority.name)
                                    .font(.footnote.weight(.medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .glassEffect(.regular.tint(.secondary.opacity(0.2)))
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        modelContext.delete(note)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    selectedNote = note
                                    isSheetPresented = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.orange)
                            }
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    // Random button
                    if notes.count >= 2 {
                        Button {
                            randomNotesGenerator()
                            isShowingAlert = true
                        } label: {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
                                .foregroundStyle(.blue.gradient)
                        }
                    }
                    
                    // Add button
                    Button {
                        selectedNote = nil   // ensure create mode
                        isSheetPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.blue.gradient)
                    }
                }
            }
        }
        .overlay {
            if notes.isEmpty {
                EmptyListView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            if !notes.isEmpty {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    
                    TextField("Search notes...", text: $searchText)
                        .textFieldStyle(.plain)
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .alert(randomNotes, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {}
        }
        //        .sheet(isPresented: $isSheetPresented) {
        //            NewNotesFormView()
        //        }
        .sheet(isPresented: $isSheetPresented, onDismiss: {
            selectedNote = nil   // reset after close
        }) {
            NewNotesFormView(noteToEdit: selectedNote)
        }
    }
    
    
}

#Preview("Sample Data") {
    ContentView()
        .modelContainer(NotesModel.preview)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: NotesModel.self, inMemory: true)
}
