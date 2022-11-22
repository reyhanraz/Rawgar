//
//  DetailGamePresenter.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 18/11/22.
//

import SwiftUI
import Combine

class DetailGamePresenter: ObservableObject {

  private let gameID: Int
  private let detailUseCase: DetailUseCase
  private var cancellables: Set<AnyCancellable> = []

  @Published var game: GameDetailModel?
  @Published var error: Error?
  @Published var loadingState: Bool = false
  var isFavorited: Bool?

  init(detailUseCase: DetailUseCase, gameID: Int) {
    self.detailUseCase = detailUseCase
    self.gameID = gameID
  }

  func getGames() {
    loadingState = true
    detailUseCase.getGame(id: gameID)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          self.loadingState = false
        case .failure(let error):
          self.error = error
        }
      } receiveValue: { value in
        self.game = value
        self.isFavorited = value.isFavorited
      }.store(in: &cancellables)
  }

  func updateFavorites(){
    loadingState = true
    detailUseCase.updateFavorite(id: gameID, isFavorited: !(isFavorited ?? false))
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          self.loadingState = false
        case .failure(let error):
          self.error = error
        }
      } receiveValue: { value in
        if value {
          self.getGames()
        }
      }.store(in: &cancellables)
  }
}
