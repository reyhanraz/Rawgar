//
//  FavoriteUseCase.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 20/11/22.
//

import Foundation
import Combine

protocol FavoriteUseCase {
  func getFavoriteGames() -> AnyPublisher<[GameDetailModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {

  private let repository: FavoriteRepositoryProtocol

  required init(repository: FavoriteRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteGames() -> AnyPublisher<[GameDetailModel], Error> {
    return repository.getFavoriteGames()
  }

}
