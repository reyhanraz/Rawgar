//
//  AboutView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI

struct AboutView: View {

  var body: some View {
    VStack {
      Spacer()
      cardView
      Spacer()
    }
    .frame(width: UIScreen.main.bounds.width)
    .background(Color.CustomDarkPurple)
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.large)
  }
}

extension AboutView {
  var imageCategory: some View {
    Image("Ava")
      .resizable()
      .scaledToFill()
      .cornerRadius(75)
      .frame(width: 150, height: 150)
      .overlay(
        RoundedRectangle(cornerRadius: 75)
          .stroke(Color.CustomDarkPurple, lineWidth: 1)
      )
  }
  var cardView: some View {
    VStack(spacing: 20) {
      imageCategory
      Text("Reyhan Rifqi Azzami")
        .foregroundColor(Color.CustomDarkPurple)
      Text(verbatim: "Reyhanazzami@gmail.com")
        .foregroundColor(Color.CustomDarkPurple)

    }
    .frame(width: UIScreen.main.bounds.width-40, height: 300)
    .background(Color.CustomWhite)
    .cornerRadius(10)
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
