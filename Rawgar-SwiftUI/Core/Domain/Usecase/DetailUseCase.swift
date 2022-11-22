//
//  DetailUseCase.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 18/11/22.
//

import Foundation
import Combine

protocol DetailUseCase {
  func getGame(id: Int) -> AnyPublisher<GameDetailModel, Error>
  func updateFavorite(id: Int, isFavorited: Bool) -> AnyPublisher<Bool, Error>
}

class DetailGameInteractor: DetailUseCase {
  
  private let repository: DetailGameRepositoryProtocol
  
  required init(repository: DetailGameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGame(id: Int) -> AnyPublisher<GameDetailModel, Error> {
    repository.getGame(id: id)
  }
  
  func updateFavorite(id: Int, isFavorited: Bool) -> AnyPublisher<Bool, Error> {
    repository.updateFavorite(id: id, isFavorited: isFavorited)
  }
}
