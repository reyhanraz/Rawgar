//
//  DetailGameView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 17/11/22.
//

import SwiftUI
import Core
import Game

struct DetailGameView: View {
  @ObservedObject var presenter: GetDetailGamePresenter<
    Interactor<Int, GameDomainModel, GetDetailGameRepository<GetDetailGameLocaleDataSource, GetDetailGameRemoteDataSource, GameTransformer>>,
      Interactor<Int, GameDomainModel, UpdateFavoriteGameRepository<GetDetailGameLocaleDataSource, GameTransformer>>>
  var gameModel: GameDomainModel
  var body: some View {
    ZStack {
      if presenter.isLoading {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        DetailGameVw(game: presenter.detail)
      }
    }
    .onAppear {
      self.presenter.getDetail(request: gameModel.id)
    }
    .navigationTitle(presenter.detail?.name ?? "")
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        Button {
          self.presenter.updateFavorite(request: gameModel.id)
        } label: {
          Image(systemName: presenter.detail?.isFavorited ?? false ? "heart.fill" : "heart")
        }
      }
    }
    
    .alert(
      "Error",
      isPresented: $presenter.isError,
      presenting: "Error"
    ) { _ in
      Button("OK", role: .cancel) {
        self.presenter.isError = false
      }
    } message: { details in
      Text(details)
    }
  }
}
