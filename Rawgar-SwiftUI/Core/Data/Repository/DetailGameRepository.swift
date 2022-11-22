//
//  DetailGameRepository.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 18/11/22.
//

import Foundation
import Combine

protocol DetailGameRepositoryProtocol{
  
  func getGame(id: Int) -> AnyPublisher<GameDetailModel, Error>
  func updateFavorite(id: Int, isFavorited: Bool) -> AnyPublisher<Bool, Error>
  
}

final class DetailGameRepository: NSObject {
  
  typealias DetailGameRepositoryInstance = (LocaleDataSource, RemoteDataSource) -> DetailGameRepository
  fileprivate let locale: LocaleDataSource
  fileprivate let remote: RemoteDataSource
  
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.locale = locale
  }
  static let sharedInstance: DetailGameRepositoryInstance = { localeRepo, remoteRepo in
    return DetailGameRepository(locale: localeRepo, remote: remoteRepo)
  }
  
}

extension DetailGameRepository: DetailGameRepositoryProtocol {
  func getGame(id: Int) -> AnyPublisher<GameDetailModel, Error> {
    return self.locale.getGame(id: id)
      .flatMap { result -> AnyPublisher<GameDetailModel, Error> in
        if result.descriptionRaw.isEmpty {
          return self.remote.getDetailGames(id: id)
            .map {GameMapper.mapGamesResponsesToEntities(input: [$0])}
            .flatMap { self.locale.addGames(from: $0)}
            .filter{ $0 }
            .flatMap { _ in
              self.locale.getGame(id: id)
                .map { GameMapper.mapGamesEntitiesToDomains(input: [$0]).first! }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getGame(id: id)
            .map { GameMapper.mapGamesEntitiesToDomains(input: [$0]).first! }
            .eraseToAnyPublisher()
          
        }
      }.eraseToAnyPublisher()
  }
  
  func updateFavorite(id: Int, isFavorited: Bool) -> AnyPublisher<Bool, Error> {
    return self.locale.updateFavorite(id: id, isFavorited: isFavorited)
  }
  
}
