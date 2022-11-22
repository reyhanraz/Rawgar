//
//  FavoritePresenter.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 20/11/22.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
  
  private let router = HomeRouter()
  private let favoriteUseCase: FavoriteUseCase
  private var cancellables: Set<AnyCancellable> = []
  
  
  @Published var games: [GameDetailModel] = []
  @Published var error: Error?
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getFavoriteGames() {
    loadingState = true
    favoriteUseCase.getFavoriteGames()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          self.loadingState = false
        case .failure(let error):
          self.error = error
        }
      } receiveValue: { value in
        self.games = value
      }.store(in: &cancellables)
  }
  func linkBuilder<Content: View>(
    for game: GameDetailModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: game)) { content() }
  }
}
