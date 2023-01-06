//
//  GameDomainModel.swift
//  Game
//
//  Created by Reyhan Rifqi on 27/12/22.
//

import Foundation

public struct GameDomainModel: Identifiable, Equatable {
  public static func == (lhs: GameDomainModel, rhs: GameDomainModel) -> Bool {
    return lhs.id == rhs.id
  }

  public let id: Int
  public let name: String?
  public let metacritic: Int?
  public let released: String?
  public let backgroundImage: String?
  public let rating: Double?
  public let ratings: [RatingDomainModel]?
  public let reviewsCount: Int?
  public let publishers: String?
  public let genres: String?
  public let descriptionRaw: String?
  public let esrbRating: String?
  public var isFavorited: Bool?

  public init(id: Int,
       name: String?,
       metacritic: Int?,
       released: String?,
       backgroundImage: String?,
       rating: Double?,
       ratings: [RatingDomainModel]?,
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

public struct RatingDomainModel: Identifiable, Equatable {
  public let id: Int
  public let count: Int
  public let percent: Double

  public init(id: Int, count: Int, percent: Double) {
    self.id = id
    self.count = count
    self.percent = percent
  }

}
