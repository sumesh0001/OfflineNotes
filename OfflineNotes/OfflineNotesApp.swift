//
//  OfflineNotesApp.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//

internal import SwiftUI
import SwiftData

@main
struct OfflineNotesApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
              .modelContainer(for: NotesModel.self)
        }
    }
}
