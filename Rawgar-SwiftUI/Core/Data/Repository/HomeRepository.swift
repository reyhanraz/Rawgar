//
//  HomeRepository.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import Combine

protocol HomeRepositoryProtocol {
  
  func getGames(query: String?, isFavorited: Bool?) -> AnyPublisher<[GameDetailModel], Error>
  
}

final class HomeRepository: NSObject {
  
  typealias HomeRepositoryInstance = (LocaleDataSource, RemoteDataSource) -> HomeRepository
  fileprivate let locale: LocaleDataSource
  fileprivate let remote: RemoteDataSource
  
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.locale = locale
  }
  static let sharedInstance: HomeRepositoryInstance = { localeRepo, remoteRepo in
    return HomeRepository(locale: localeRepo, remote: remoteRepo)
  }
  
}

extension HomeRepository: HomeRepositoryProtocol {
  
  func getGames(query: String? = nil, isFavorited: Bool? = nil) -> AnyPublisher<[GameDetailModel], Error> {
    return self.locale.getGames(query: query, isFavorited: isFavorited)
      .flatMap { result -> AnyPublisher<[GameDetailModel], Error>  in
        if result.isEmpty {
          return self.remote.getGames(query: query)
            .map { GameMapper.mapGamesResponsesToEntities(input: $0) }
            .flatMap { self.locale.addGames(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getGames(query: query)
                .map { GameMapper.mapGamesEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getGames(query: query, isFavorited: isFavorited)
            .map { GameMapper.mapGamesEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
