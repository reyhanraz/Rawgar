//
//  RatingProgressView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 17/11/22.
//

import SwiftUI

struct RatingProgressView: View {
  let starId: Int
  let percentage: Double
  let ratingCount: Int
  var body: some View {
    HStack {
      Image(systemName: "star.fill")
        .foregroundColor(Color.CustomBorderColor)
      Text("\(starId)")
        .foregroundColor(Color.CustomBorderColor)
        .font(.system(size: 14))
      Spacer()
      if #available(iOS 16.0, *) {
        ProgressView(value: percentage, total: 100)
          .tint(Color.CustomWhite)
          .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
      } else {
        ProgressView(value: percentage, total: 100)
          .progressViewStyle(LinearProgressViewStyle(tint: Color.CustomWhite))
          .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
      }
      Spacer()
      Text("\(ratingCount)")
        .frame(width: 50, alignment: .trailing)
        .foregroundColor(Color.CustomWhite)
        .font(.system(size: 14))
      
    }
    .background(Color.CustomDarkPurple)
  }
}

struct RatingProgressView_Previews: PreviewProvider {
  static var previews: some View {
    RatingProgressView(starId: 5, percentage: 70, ratingCount: 3000)
  }
}
