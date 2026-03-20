//
//  ButtonImageView.swift
//  OfflineNotes
//
//  Created by Sumesh on 26/02/26.
//


internal import SwiftUI

struct ButtonImageView: View {
  let symbolName: String
  
  var body: some View {
    Image(systemName: symbolName)
      .resizable()
      .scaledToFit()
      .foregroundStyle(.blue.gradient)
      .padding(8)
      .background(
        Circle()
          .fill(.ultraThickMaterial)
      )
      .frame(width: 80)
      .glassEffect(.regular.interactive()) // TODO: - NEW CODE
  }
}

#Preview {
  ButtonImageView(symbolName: "plus.circle.fill")
}
