//
//  GamesTransformer.swift
//  Game
//
//  Created by Reyhan Rifqi on 27/12/22.
//

import Foundation
import Core

public struct GameTransformer: Mapper {

  public typealias Response = [GameDetailResponse]
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [GameDomainModel]

  public init() {}

  public func transformResponseToEntity(response: [GameDetailResponse]) -> [GameModuleEntity] {
    return response.map { result in
      let _ratings = result.ratings.map { ratings in
        return ratings.map { rating in
          let ratingEntity = RatingModuleEntity()
          ratingEntity.id = UUID().uuidString
          ratingEntity.gameID = result.id
          ratingEntity.ratingID = rating.id
          ratingEntity.ratingCount = rating.count
          ratingEntity.ratingPercent = rating.percent
          return ratingEntity
        }
      }

      let newGame = GameModuleEntity()
      newGame.descriptionRaw = result.descriptionRaw ?? ""
      newGame.gameID = result.id
      newGame.image = result.backgroundImage ?? ""
      newGame.metacritics = result.metacritic ?? 0
      newGame.name = result.name ?? ""
      newGame.released = result.released ?? ""
      newGame.reviewsCount = result.reviewsCount ?? 0
      newGame.rating = result.rating ?? 0
      newGame.ratings.append(objectsIn: _ratings ?? [])
      newGame.publisherTitles = result.publisherTitle ?? ""
      newGame.genreTitles = result.genreTitle ?? ""
      newGame.esrbRating = result.esrbRating?.name ?? ""
      newGame.dateAdded = Date()
      return newGame
    }
  }

  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameDomainModel] {
    return entity.map { result in

      let _ratings = Array(result.ratings).map { ratingEntity -> RatingDomainModel in
        RatingDomainModel(id: ratingEntity.ratingID, count: ratingEntity.ratingCount, percent: ratingEntity.ratingPercent)
      }

      return GameDomainModel(id: result.gameID,
                             name: result.name,
                             metacritic: result.metacritics,
                             released: result.released,
                             backgroundImage: result.image,
                             rating: result.rating,
                             ratings: _ratings,
                             reviewsCount: result.reviewsCount,
                             publishers: result.publisherTitles,
                             genres: result.genreTitles,
                             descriptionRaw: result.descriptionRaw,
                             esrbRating: result.esrbRating, isFavorited: result.isFavorited
      )
    }
  }
}
