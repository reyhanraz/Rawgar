//
//  Injection.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import RealmSwift
import Core
import Game
import SwiftUI

final class Injection: NSObject {

  static func provideHomeUseCase<U: UseCase>() -> U where U.Request == GameListRequest, U.Response == [GameDomainModel] {

    let realm = try! Realm()

    let locale = GetGamesLocaleDataSource(realm: realm)

    let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.listGames.url)

    let mapper = GameTransformer()

    let repository = GetGamesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  static func provideDetailUseCase<U: UseCase>() -> U where U.Request == Int, U.Response == GameDomainModel {

    let realm = try! Realm()

    let locale = GetDetailGameLocaleDataSource(realm: realm)

    let remote = GetDetailGameRemoteDataSource(endpoint: Endpoints.Gets.detailGame.url)

    let mapper = GameTransformer()

    let repository = GetDetailGameRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  static func provideUpdateFavoriteUseCase<U: UseCase>() -> U where U.Request == Int, U.Response == GameDomainModel {

    let realm = try! Realm()

    let locale = GetDetailGameLocaleDataSource(realm: realm)

    let mapper = GameTransformer()

    let repository = UpdateFavoriteGameRepository(
      localeDataSource: locale,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }
}
