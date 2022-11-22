//
//  TitleBodyLabel.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 17/11/22.
//

import SwiftUI

struct TitleBodyLabel: View {
  let title: String
  let desc: String
  var body: some View {
    
    HStack{
      Text(title)
        .foregroundColor(.CustomBorderColor)
        .font(.system(size: 14))
      
      Spacer()
      
      Text(desc)
        .foregroundColor(.CustomWhite)
        .font(.system(size: 14))
      
      
    }
  }
}

struct TitleBodyLabel_Previews: PreviewProvider {
  static var previews: some View {
    TitleBodyLabel(title: "Metascore", desc: "\(91)")
  }
}
