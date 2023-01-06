//
//  HomeRouter.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI
import Core
import Game

class HomeRouter {

  func makeDetailView(for game: GameDomainModel) -> some View {
    let presenter = GetDetailGamePresenter<
      Interactor<Int, GameDomainModel, GetDetailGameRepository<GetDetailGameLocaleDataSource, GetDetailGameRemoteDataSource, GameTransformer>>,
        Interactor<Int, GameDomainModel, UpdateFavoriteGameRepository<GetDetailGameLocaleDataSource, GameTransformer>>>(
          gameUseCase: Injection.provideDetailUseCase(),
          updateFavoriteUseCase: Injection.provideUpdateFavoriteUseCase(),
      gameID: game.id)
    return DetailGameView(presenter: presenter, gameModel: game)
  }
}
