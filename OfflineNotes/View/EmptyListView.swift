//
//  EmptyListView.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//


internal import SwiftUI

struct EmptyListView: View {
  var body: some View {
    ContentUnavailableView {
      Circle()
        .fill(.blue.gradient)
        .stroke(.blue.gradient.opacity(0.15), lineWidth: 30)
        .stroke(.blue.gradient.opacity(0.15), lineWidth: 60)
        .stroke(.blue.gradient.opacity(0.15), lineWidth: 90)
        .frame(width: 180)
        .glassEffect() // TODO: - NEW CODE
        .overlay {
          Image(systemName: "list.clipboard")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .foregroundStyle(Color(UIColor.secondarySystemBackground))
            .padding(.top, -6)
        }
        .padding(.bottom, 90)
    } description: {
      GroupBox {
        TabView {
          PageTabView(icon: "1.circle", description: "Write, edit, and organize your notes anytime, even without internet")
            .padding(.bottom, 36)
          
          PageTabView(icon: "2.circle", description: "Seamless sync keeps everything updated across sessions")
            .padding(.bottom, 36)
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(minWidth: 0, maxWidth: 560, minHeight: 120, maxHeight: 180)
      }
    }
  }
}

#Preview("Light Theme") {
  EmptyListView()
}

#Preview("Dark Theme") {
  EmptyListView()
    .preferredColorScheme(.dark)
}
