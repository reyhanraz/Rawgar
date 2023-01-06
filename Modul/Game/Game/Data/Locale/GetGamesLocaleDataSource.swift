//
//  GetGamesLocaleDataSource.swift
//  Game
//
//  Created by Reyhan Rifqi on 27/12/22.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetGamesLocaleDataSource: LocaleDataSource {

  public typealias Request = GameListRequest

  public typealias Response = [GameModuleEntity]

  private let _realm: Realm

  public init(realm: Realm) {
      _realm = realm
  }
}

extension GetGamesLocaleDataSource {
  public func execute(request: Request?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
        let _games: Results<GameModuleEntity>

        if let query = request?.searchQuery, let isFavorited = request?.isFavorited {
          _games = _realm.objects(GameModuleEntity.self).where({
            $0.name.contains(query, options: .caseInsensitive) && $0.isFavorited == isFavorited
          })
        } else if let query = request?.searchQuery {
          _games = _realm.objects(GameModuleEntity.self).where({
            $0.name.contains(query, options: .caseInsensitive)
          })
        } else if let isFavorited = request?.isFavorited {
          _games = _realm.objects(GameModuleEntity.self).where({
            $0.isFavorited == isFavorited
          })
        } else {
          _games = _realm.objects(GameModuleEntity.self)
        }

        completion(.success(_games.toArray(ofType: GameModuleEntity.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
        do {
          try _realm.write {
            for game in entities {
              _realm.add(game, update: .modified)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
    }.eraseToAnyPublisher()
  }

  public func updateFavoriteGames(by gameId: Int) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
        completion(.failure(DatabaseError.requestFailed))
    }.eraseToAnyPublisher()
  }
}

public struct GameListRequest {
  public var isFavorited: Bool?
  public var searchQuery: String?

  public init(isFavorited: Bool? = nil, searchQuery: String? = nil) {
    self.isFavorited = isFavorited
    self.searchQuery = searchQuery
  }
}
