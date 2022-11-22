//
//  EmptyView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 22/11/22.
//

import SwiftUI

struct EmptyView: View {
  var body: some View {
    VStack {
      Spacer()
      Text("You Dont Have Any Favorited Game")
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(.CustomWhite)
      Spacer()
    }
    .frame(width: UIScreen.main.bounds.width)
  }
}

struct EmptyView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyView()
  }
}
