//
//  UpdateFavoriteGameRepository.swift
//  Game
//
//  Created by Reyhan Rifqi on 05/01/23.
//

import Core
import Combine

public struct UpdateFavoriteGameRepository<
  GameLocaleDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where
GameLocaleDataSource.Response == GameModuleEntity,
GameLocaleDataSource.Request == Int,
Transformer.Response == [GameDetailResponse],
Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameDomainModel] {

  public typealias Request = Int
  public typealias Response = GameDomainModel

  private let _localeDataSource: GameLocaleDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: GameLocaleDataSource,
    mapper: Transformer) {

      _localeDataSource = localeDataSource
      _mapper = mapper
    }

  public func execute(request: Request?) -> AnyPublisher<GameDomainModel, Error> {
    return _localeDataSource.updateFavoriteGames(by: request ?? 0)
      .map {_mapper.transformEntityToDomain(entity: [$0]).first!}
      .eraseToAnyPublisher()
  }
}
