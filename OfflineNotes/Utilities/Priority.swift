//
//  Priority.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//

import Foundation

enum Priority: Int, Codable, CaseIterable, Identifiable {
    var id: Int {
        rawValue
    }
    
    case low         = 1
    case medium      = 2
    case high        = 3
    
}

extension Priority {
    var name: String {
        switch self {
            
        case .low:
            "Low"
        case .medium:
            "Medium"
        case .high:
            "High"
        }
    }
}
