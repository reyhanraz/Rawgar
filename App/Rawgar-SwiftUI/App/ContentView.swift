//
//  ContentView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 15/11/22.
//

import SwiftUI
import Core
import Game

struct ContentView: View {
  @EnvironmentObject var homePresenter: GetListPresenter<GameListRequest, GameDomainModel, Interactor<GameListRequest, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  @EnvironmentObject var favoritePresenter: GetListPresenter<GameListRequest, GameDomainModel, Interactor<GameListRequest, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  var body: some View {
    if #available(iOS 16.0, *) {
      tabView
        .tint(Color.CustomDarkPurple)
    } else {
      tabView
        .accentColor(Color.CustomDarkPurple)
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
      }.tabItem {
        Label("Profile", systemImage: "person.crop.circle.fill")
      }
    }
  }
}
