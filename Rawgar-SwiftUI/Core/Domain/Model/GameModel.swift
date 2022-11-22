//
//  GameModel.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation

struct GameDetailModel: Identifiable, Equatable {
  static func == (lhs: GameDetailModel, rhs: GameDetailModel) -> Bool {
    return lhs.id == rhs.id
  }
  
  let id: Int
  let name: String?
  let metacritic: Int?
  let released: String?
  let backgroundImage: String?
  let rating: Double?
  let ratings: [RatingModel]?
  let reviewsCount: Int?
  let publishers: String?
  let genres: String?
  let descriptionRaw: String?
  let esrbRating: String?
  let isFavorited: Bool?
  
  init(id: Int,
       name: String?,
       metacritic: Int?,
       released: String?,
       backgroundImage: String?,
       rating: Double?,
       ratings: [RatingModel]?,
       reviewsCount: Int?,
       publishers: String?,
       genres: String?,
       descriptionRaw: String?,
       esrbRating: String?,
       isFavorited: Bool?) {
    
    self.id = id
    self.name = name
    self.metacritic = metacritic
    self.released = released
    self.backgroundImage = backgroundImage
    self.rating = rating
    self.ratings = ratings
    self.reviewsCount = reviewsCount
    self.publishers = publishers
    self.genres = genres
    self.descriptionRaw = descriptionRaw
    self.esrbRating = esrbRating
    self.isFavorited = isFavorited
  }
}


struct RatingModel: Identifiable, Equatable {
  let id: Int
  let count: Int
  let percent: Double
}
