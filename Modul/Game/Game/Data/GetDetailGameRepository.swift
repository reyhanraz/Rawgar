//
//  GetDetailGameRepository.swift
//  Game
//
//  Created by Reyhan Rifqi on 04/01/23.
//

import Core
import Combine

public struct GetDetailGameRepository<
  GameLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
// 2
GameLocaleDataSource.Response == GameModuleEntity,
GameLocaleDataSource.Request == Int,
RemoteDataSource.Response == GameDetailResponse,
RemoteDataSource.Request == Int,
Transformer.Response == [GameDetailResponse],
Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameDomainModel] {

  // 3
  public typealias Request = Int
  public typealias Response = GameDomainModel

  private let _localeDataSource: GameLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: GameLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {

      _localeDataSource = localeDataSource
      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }

  public func execute(request: Request?) -> AnyPublisher<GameDomainModel, Error> {
    return _localeDataSource.execute(request: request)
      .flatMap { result -> AnyPublisher<GameDomainModel, Error> in
        if result.descriptionRaw.isEmpty {
          return self._remoteDataSource.execute(request: request)
            .map {self._mapper.transformResponseToEntity(response: [$0])}
            .flatMap { self._localeDataSource.add(entities: $0[0])}
            .filter { $0 }
            .flatMap { _ in
              self._localeDataSource.execute(request: request)
                .map { self._mapper.transformEntityToDomain(entity: [$0]).first! }
            }
            .eraseToAnyPublisher()
        } else {
          return self._localeDataSource.execute(request: request)
            .map { self._mapper.transformEntityToDomain(entity: [$0]).first! }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  public func updateFavorite(id: Int) -> AnyPublisher<GameDomainModel, Error> {
    return _localeDataSource.updateFavoriteGames(by: id)
      .map {_mapper.transformEntityToDomain(entity: [$0]).first!}
      .eraseToAnyPublisher()
  }
}
