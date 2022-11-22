//
//  LocalDataSource.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import Combine
import RealmSwift

protocol LocalDataSourceProtocol: AnyObject {
  
  func getGames(query: String?, isFavorited: Bool?) -> AnyPublisher<[GameEntity], Error>
  func addGames(
    from games: [GameEntity]) -> AnyPublisher<Bool, Error>
  func updateFavorite(id: Int, isFavorited: Bool) -> AnyPublisher<Bool, Error>
  func getGame(id: Int) -> AnyPublisher<GameEntity, Error>
  
}

final class LocaleDataSource: NSObject {
  
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
  
}

extension LocaleDataSource: LocalDataSourceProtocol {
  func getGame(id: Int) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      if let realm = self.realm {
        let gameResult = realm.objects(GameEntity.self).where({
          $0.gameID == id
        })
        
        guard let _game = gameResult.first else {
          completion(.failure(DatabaseError.invalidInstance))
          return
        }
        
        completion(.success(_game))
        
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  
  func getGames(query: String? = nil, isFavorited: Bool? = nil) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let _categories: Results<GameEntity>
        
        if let query = query, let isFavorited = isFavorited {
          _categories = realm.objects(GameEntity.self).where({
            $0.name.contains(query, options: .caseInsensitive) && $0.isFavorited == isFavorited
          })
        } else if let query = query {
          _categories = realm.objects(GameEntity.self).where({
            $0.name.contains(query, options: .caseInsensitive)
          })
        } else if let isFavorited = isFavorited {
          _categories = realm.objects(GameEntity.self).where({
            $0.isFavorited == isFavorited
          })
        } else {
          _categories = realm.objects(GameEntity.self)
        }
        
        completion(.success(_categories.toArray(ofType: GameEntity.self)))
        
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in games {
              realm.add(game, update: .modified)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateFavorite(id: Int, isFavorited: Bool) -> AnyPublisher<Bool, Error>{
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        let gameResult = realm.objects(GameEntity.self).where({
          $0.gameID == id
        })
        
        guard let _game = gameResult.first else {
          completion(.failure(DatabaseError.invalidInstance))
          return
        }
        
        do {
          try realm.write {
            _game.isFavorited = isFavorited
            realm.add(_game, update: .all)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
