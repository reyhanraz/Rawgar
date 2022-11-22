//
//  ContentView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 15/11/22.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter

  var body: some View {
    if #available(iOS 16.0, *) {
      tabView
        .tint(Color.CustomDarkPurple)
    } else {
      tabView
        .accentColor(Color.CustomDarkPurple)
      // Fallback on earlier versions
    }
  }

  var tabView: some View {
    TabView {
      NavigationView {
        HomeView(presenter: homePresenter)
      }.tabItem {
        Label("Home", systemImage: "gamecontroller.fill")
      }

      NavigationView {
        FavoriteView(presenter: favoritePresenter)
      }.tabItem {
        Label("Favorite", systemImage: "heart.fill")
      }

      NavigationView {
        AboutView()
      }.tabItem{
        Label("Profile", systemImage: "person.crop.circle.fill")
      }
    }
  }
}
