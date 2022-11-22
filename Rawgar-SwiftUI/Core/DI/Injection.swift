//
//  Injection.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

  static let sharedInstance: Injection = {
    return Injection()
  }()

  private let realm: Realm?

  private override init() {
    realm = try? Realm()
  }

  private func provideRepository() -> HomeRepositoryProtocol {
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    return HomeRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideHomePresenter() -> HomePresenter {
    let usecase = provideHome()
    return HomePresenter(homeUseCase: usecase)
  }

  func provideDetailRepository() -> DetailGameRepositoryProtocol {
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    return DetailGameRepository.sharedInstance(locale, remote)
  }

  func provideDetail() -> DetailUseCase {
    let repository = provideDetailRepository()
    return DetailGameInteractor(repository: repository)
  }

  func provideDetailGamePresenter(gameId: Int) -> DetailGamePresenter {
    let usecase = provideDetail()
    return DetailGamePresenter(detailUseCase: usecase, gameID: gameId)
  }

  func provideFavoriteRepository() -> FavoriteRepositoryProtocol {
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    return FavoriteRepository.sharedInstance(locale)
  }

  func provideFavorite() -> FavoriteUseCase {
    let repository = provideFavoriteRepository()
    return FavoriteInteractor(repository: repository)
  }

  func provideFavoriteGamePresenter() -> FavoritePresenter {
    let usecase = provideFavorite()
    return FavoritePresenter(favoriteUseCase: usecase)
  }

}
