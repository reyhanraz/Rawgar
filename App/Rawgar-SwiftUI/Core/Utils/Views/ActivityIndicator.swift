//
//  ActivityIndicator.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 22/11/22.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

  func makeUIView(
    context: UIViewRepresentableContext<ActivityIndicator>
  ) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: .large)
  }

  func updateUIView(
    _ uiView: UIActivityIndicatorView,
    context: UIViewRepresentableContext<ActivityIndicator>
  ) {
    uiView.startAnimating()
  }

}
