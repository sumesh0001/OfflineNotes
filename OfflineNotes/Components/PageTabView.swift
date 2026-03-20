//
//  PageTabView.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//


internal import SwiftUI

struct PageTabView: View {
  var icon: String
  var description: String
  
  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: icon)
        .imageScale(.large)
        .font(.largeTitle.weight(.light))
        .symbolEffect(.breathe)
      
      Text(description)
        .font(.title.weight(.light))
        .fontWidth(.compressed)
        .multilineTextAlignment(.center)
    }
  }
}

#Preview {
  PageTabView(icon: "1.circle", description: "Write, edit, and organize your notes anytime, even without internet")
    .padding()
}
