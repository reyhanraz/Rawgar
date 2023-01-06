//
//  HomeView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI
import Core
import Game

struct HomeView: View {
  @ObservedObject var presenter: GetListPresenter<GameListRequest, GameDomainModel, Interactor<GameListRequest, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  let homeGrid = [GridItem(.flexible()), GridItem(.flexible())]

  var body: some View {
    ZStack {
      if presenter.isLoading {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        ScrollView {
          LazyVGrid(columns: homeGrid) {
            ForEach(presenter.list, id: \.id) { game in
              linkBuilder(for: game) {
                  GameRow(game: game)
              }.buttonStyle(PlainButtonStyle())
            }
          }
          .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
      }
    }
    .background(Color.CustomDarkPurple)
    .searchable(text: $presenter.searchText, prompt: "Search Games")
    .onReceive(presenter.$debouncedText) { (val) in
      if !val.isEmpty {
        let request = GameListRequest(isFavorited: false, searchQuery: val)
        self.presenter.getList(request: request)
      } else {
        self.presenter.getList(request: nil)
      }
    }
    .onAppear {
      self.presenter.getList(request: nil)
    }
    .alert(
      "Error",
      isPresented: $presenter.isError,
      presenting: presenter.errorMessage
    ) { _ in
      Button("OK", role: .cancel) {
        self.presenter.isError = false
      }
    } message: { details in
      Text(details)
    }
    .navigationTitle("Games")
    .navigationBarTitleDisplayMode(.automatic)
  }
}

extension HomeView {

  func linkBuilder<Content: View>(
      for game: GameDomainModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
        destination: HomeRouter().makeDetailView(for: game)) { content() }
    }
}
