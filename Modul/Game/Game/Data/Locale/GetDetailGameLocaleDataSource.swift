//
//  GetDetailGameLocaleDataSource.swift
//  Game
//
//  Created by Reyhan Rifqi on 04/01/23.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetDetailGameLocaleDataSource: LocaleDataSource {

  public typealias Request = Int

  public typealias Response = GameModuleEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

}

extension GetDetailGameLocaleDataSource {
  public func execute(request: Int?) -> AnyPublisher<GameModuleEntity, Error> {
    return Future<GameModuleEntity, Error> { completion in
      guard let id = request else {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      let gameResult = _realm.objects(GameModuleEntity.self).where({
        $0.gameID == id
      })

      guard let _game = gameResult.first else {
        completion(.failure(DatabaseError.invalidInstance))
        return
      }

      completion(.success(_game))

    }.eraseToAnyPublisher()
  }

  public func add(entities: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in

      do {
        try _realm.write {
          _realm.add(entities, update: .modified)
        }
        completion(.success(true))

      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }

    }.eraseToAnyPublisher()
  }

  public func updateFavoriteGames(by gameId: Int) -> AnyPublisher<GameModuleEntity, Error> {
    return Future<GameModuleEntity, Error> { completion in
      if let gameEntity = {
        _realm.objects(GameModuleEntity.self).filter("gameID = \(gameId)")
      }().first {
        do {
          try _realm.write {
            gameEntity.setValue(!gameEntity.isFavorited, forKey: "isFavorited")
          }
          completion(.success(gameEntity))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}
