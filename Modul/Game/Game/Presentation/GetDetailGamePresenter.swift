//
//  GetDetailGamePresenter.swift
//  Game
//
//  Created by Reyhan Rifqi on 05/01/23.
//

import Foundation
import Core
import Combine

public class GetDetailGamePresenter<GameUseCase: UseCase, UpdateFavoriteUseCase: UseCase>: ObservableObject
where
GameUseCase.Request == Int, GameUseCase.Response == GameDomainModel,
UpdateFavoriteUseCase.Request == Int, UpdateFavoriteUseCase.Response == GameDomainModel {

  private let gameUseCase: GameUseCase
  private let favoriteUseCase: UpdateFavoriteUseCase

  private let gameID: Int

  public var cancellables: Set<AnyCancellable> = []

  @Published public var detail: GameDomainModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(gameUseCase: GameUseCase, updateFavoriteUseCase: UpdateFavoriteUseCase, gameID: Int) {
    self.favoriteUseCase = updateFavoriteUseCase
    self.gameUseCase = gameUseCase
    self.gameID = gameID

  }

  public func getDetail(request: GameUseCase.Request) {
    isLoading = true
    gameUseCase.execute(request: request)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isError = true
                self.isLoading = false
            case .finished:
                self.isLoading = false
            }
        }, receiveValue: { detail in
            self.detail = detail
        })
        .store(in: &cancellables)
  }

  public func updateFavorite(request: UpdateFavoriteUseCase.Request) {
    favoriteUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
              self.errorMessage = error.localizedDescription
              self.isError = true
              self.isLoading = false
          case .finished:
              self.isLoading = false
          }
      }, receiveValue: { detail in
          self.detail = detail
      })
      .store(in: &cancellables)
  }

}
