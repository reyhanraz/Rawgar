//
//  RawgarApp.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 15/11/22.
//

import UIKit
import SwiftUI
import Game
import Core

@main
struct RawgarApp: SwiftUI.App {

  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  @StateObject private var homePresenter = GetListPresenter<GameListRequest, GameDomainModel, Interactor<GameListRequest, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>(useCase: Injection.provideHomeUseCase())
  @StateObject private var favoritePresenter = GetListPresenter<GameListRequest, GameDomainModel, Interactor<GameListRequest, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>(useCase: Injection.provideHomeUseCase())
  
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

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    Theme.navigationBarColors()
    return true
  }
}
