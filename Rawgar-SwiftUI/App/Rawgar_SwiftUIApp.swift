//
//  Rawgar_SwiftUIApp.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 15/11/22.
//

import SwiftUI

@main
struct Rawgar_SwiftUIApp: App {
  init() {
    Theme.navigationBarColors()
  }

  @StateObject private var homePresenter = Injection.sharedInstance.provideHomePresenter()
  @StateObject private var favoritePresenter = Injection.sharedInstance.provideFavoriteGamePresenter()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
          .environmentObject(homePresenter)
          .environmentObject(favoritePresenter)
      }
    }
  }
}
