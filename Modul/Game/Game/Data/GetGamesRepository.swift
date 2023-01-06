//
//  GetGamesRepository.swift
//  Game
//
//  Created by Reyhan Rifqi on 03/01/23.
//

import Core
import Combine

public struct GetGamesRepository<
    GamesLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    // 2
    GamesLocaleDataSource.Response == [GameModuleEntity],
    GamesLocaleDataSource.Request == GameListRequest,
    RemoteDataSource.Response == [GameDetailResponse],
    RemoteDataSource.Request == GameListRequest,
    Transformer.Response == [GameDetailResponse],
    Transformer.Entity == [GameModuleEntity],
    Transformer.Domain == [GameDomainModel] {

    // 3
    public typealias Request = GameListRequest
    public typealias Response = [GameDomainModel]

    private let _localeDataSource: GamesLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: GamesLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {

        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }

    // 4
    public func execute(request: Request?) -> AnyPublisher<[GameDomainModel], Error> {
        return _localeDataSource.execute(request: request)
          .flatMap { result -> AnyPublisher<[GameDomainModel], Error> in
            if result.isEmpty && request?.isFavorited != true {
              return _remoteDataSource.execute(request: request)
                .map { _mapper.transformResponseToEntity(response: $0)}
                .catch { _ in _localeDataSource.execute(request: request) }
                .flatMap { _localeDataSource.add(entities: $0) }
                .filter { $0 }
                .flatMap { _ in _localeDataSource.execute(request: request)
                  .map { _mapper.transformEntityToDomain(entity: $0) }
                }
                .eraseToAnyPublisher()
            } else {
              return _localeDataSource.execute(request: request)
                .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
}
