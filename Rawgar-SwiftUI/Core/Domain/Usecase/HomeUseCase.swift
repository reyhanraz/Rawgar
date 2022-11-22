//
//  HomeUseCase.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import Combine

protocol HomeUseCase {
  
  func getGames(query: String?, isFavorited: Bool?) -> AnyPublisher<[GameDetailModel], Error>
  
}

class HomeInteractor: HomeUseCase {
  
  private let repository: HomeRepositoryProtocol
  
  required init(repository: HomeRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGames(query: String?, isFavorited: Bool?) -> AnyPublisher<[GameDetailModel], Error> {
    return repository.getGames(query: query, isFavorited: isFavorited)
  }
  
}
