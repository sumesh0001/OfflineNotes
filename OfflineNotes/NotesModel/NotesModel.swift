//
//  NotesModel.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//

import Foundation
import SwiftData

@Model
class NotesModel {
    var title: String
    var priority: Priority
    
    init(title: String, priority: Priority) {
      self.title = title
      self.priority = priority
    }
  }

  extension NotesModel {
    @MainActor
    static var preview: ModelContainer {
      let container = try! ModelContainer(for: NotesModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
      
      container.mainContext.insert(NotesModel(title: "Drink water", priority: Priority(rawValue: 1)!))
      container.mainContext.insert(NotesModel(title: "Going to gym", priority: Priority(rawValue: 2)!))
      container.mainContext.insert(NotesModel(title: "Learn new skills", priority: Priority(rawValue: 3)!))
      
      return container
    }
}
