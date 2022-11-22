//
//  GamesMapper.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import RealmSwift

final class GameMapper {
  
  static func mapGamesResponsesToDomains(
    input gameResponse: [GameDetailResponse]
  ) -> [GameDetailModel] {
    
    return gameResponse.map { result in
      let _ratings = result.ratings.map { x -> [RatingModel] in
        return x.map { _ratingResponse in
          RatingModel(id: _ratingResponse.id,
                      count: _ratingResponse.count,
                      percent: _ratingResponse.percent)
        }
      }
      
      return GameDetailModel(id: result.id,
                             name: result.name,
                             metacritic: result.metacritic,
                             released: result.released,
                             backgroundImage: result.backgroundImage,
                             rating: result.rating,
                             ratings: _ratings,
                             reviewsCount: result.reviewsCount,
                             publishers: result.publisherTitle,
                             genres: result.genreTitle,
                             descriptionRaw: result.descriptionRaw,
                             esrbRating: result.esrbRating?.name,
                             isFavorited: false
      )
    }
  }
  
  static func mapGamesResponsesToEntities(
    input gameResponse: [GameDetailResponse]
  ) -> [GameEntity] {
    return gameResponse.map { result in
      let _ratings = result.ratings.map { ratings in
        return ratings.map { rating in
          let ratingEntity = RatingEntity()
          ratingEntity.id = UUID().uuidString
          ratingEntity.gameID = result.id
          ratingEntity.ratingID = rating.id
          ratingEntity.ratingCount = rating.count
          ratingEntity.ratingPercent = rating.percent
          return ratingEntity
        }
      }
      
      let newGame = GameEntity()
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
  
  static func mapGamesEntitiesToDomains(
    input gameEntities: [GameEntity]
  ) -> [GameDetailModel] {
    return gameEntities.map { result in
      
      let _ratings = Array(result.ratings).map { ratingEntity -> RatingModel in
        RatingModel(id: ratingEntity.ratingID, count: ratingEntity.ratingCount, percent: ratingEntity.ratingPercent)
      }
      
      return GameDetailModel(id: result.gameID,
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
