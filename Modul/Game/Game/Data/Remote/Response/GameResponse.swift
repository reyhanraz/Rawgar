//
//  GameResponse.swift
//  Game
//
//  Created by Reyhan Rifqi on 30/12/22.
//

import Foundation

public struct GamesResponse: Codable {
  public let count: Int?
  public let next: String?
  public let previous: String?
  public let results: [GameDetailResponse]

  enum CodingKeys: String, CodingKey {
    case count, next, previous, results
  }
}

public class GameDetailResponse: Codable {
  public let id: Int
  public let name: String?
  public let metacritic: Int?
  public let released: String?
  public let backgroundImage: String?
  public let rating: Double?
  public let ratings: [Rating]?
  public let reviewsCount: Int?
  public let publishers: [Publisher]?
  public let genres: [Genre]?
  public let descriptionRaw: String?
  public let esrbRating: EsrbRating?

  enum CodingKeys: String, CodingKey {
    case id, name
    case metacritic
    case released
    case backgroundImage = "background_image"
    case rating
    case ratings
    case reviewsCount = "reviews_count"
    case genres, publishers
    case descriptionRaw = "description_raw"
    case esrbRating
  }

  public init(id: Int,
       name: String?,
       metacritic: Int?,
       released: String?,
       backgroundImage: String?,
       rating: Double?,
       ratings: [Rating]?,
       reviewsCount: Int?,
       publishers: [Publisher]?,
       genres: [Genre]?,
       descriptionRaw: String?,
       esrbRating: EsrbRating?) {

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
  }
}

extension GameDetailResponse {
  public var genreTitle: String? {
    guard let genres = genres else { return nil }
    return genres.map({ $0.name }).joined(separator: ", ")
  }

  public var publisherTitle: String? {
    guard let publishers = publishers else { return nil }
    return publishers.map({ $0.name }).joined(separator: ", ")
  }

}

public struct Publisher: Codable {
  public let id: Int
  public let name: String

  enum CodingKeys: String, CodingKey {
    case id, name
  }
}

public struct Genre: Codable {
  public let id: Int
  public let name: String

  enum CodingKeys: String, CodingKey {
    case id, name
  }
}

public struct Rating: Codable {
  public let id: Int
  public let count: Int
  public let percent: Double
}

public struct EsrbRating: Codable {
  public let name: String
}
