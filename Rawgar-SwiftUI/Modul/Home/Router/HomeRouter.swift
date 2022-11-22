//
//  HomeRouter.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for game: GameDetailModel) -> some View {
    let presenter = Injection.sharedInstance.provideDetailGamePresenter(gameId: game.id)
    return DetailGameView(presenter: presenter)
  }
}
