//
//  FavoriteRepository.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 20/11/22.
//

import Foundation
import Combine

protocol FavoriteRepositoryProtocol {

  func getFavoriteGames() -> AnyPublisher<[GameDetailModel], Error>
  
}

final class FavoriteRepository: NSObject {

  typealias FavoriteRepositoryInstance = (LocaleDataSource) -> FavoriteRepository
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource) {
    self.locale = locale
  }
  static let sharedInstance: FavoriteRepositoryInstance = { localeRepo in
    return FavoriteRepository(locale: localeRepo)
  }

}

extension FavoriteRepository: FavoriteRepositoryProtocol {

  func getFavoriteGames() -> AnyPublisher<[GameDetailModel], Error> {
    return self.locale.getGames(isFavorited: true)
      .map { GameMapper.mapGamesEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
}
