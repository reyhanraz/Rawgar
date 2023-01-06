//
//  FavoriteView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI
import Core
import Game

struct FavoriteView: View {
  @ObservedObject var presenter: GetListPresenter<GameListRequest,
                                                  GameDomainModel,
                                                  Interactor<GameListRequest,
                                                             [GameDomainModel],
                                                             GetGamesRepository<GetGamesLocaleDataSource,
                                                                                GetGamesRemoteDataSource,
                                                                                GameTransformer>>>

  var body: some View {
    ZStack {
      if presenter.isLoading {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        if presenter.list.count == 0 {
          EmptyView()
        } else {
          ScrollView {
            LazyVStack(spacing: 16) {
              ForEach(presenter.list, id: \.id) { game in
                linkBuilder(for: game) {
                  FavoriteGameView(game: game)
                }.buttonStyle(PlainButtonStyle())
              }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
          }
        }
      }
    }

    .background(Color.CustomDarkPurple)
    .onAppear {
      self.presenter.getList(request: GameListRequest(isFavorited: true))
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
    .navigationTitle("Favorite")
    .navigationBarTitleDisplayMode(.automatic)
  }
}

extension FavoriteView {
  func linkBuilder<Content: View>(
    for game: GameDomainModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: FavoriteRouter().makeDetailView(for: game)) { content() }
  }
}
