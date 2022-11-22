//
//  GamesResponse.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation

struct GamesResponse: Codable {
  let count: Int?
  let next: String?
  let previous: String?
  let results: [GameDetailResponse]

  enum CodingKeys: String, CodingKey {
    case count, next, previous, results
  }
}

class GameDetailResponse: Codable {
  let id: Int
  let name: String?
  let metacritic: Int?
  let released: String?
  let backgroundImage: String?
  let rating: Double?
  let ratings: [Rating]?
  let reviewsCount: Int?
  let publishers: [Publisher]?
  let genres: [Genre]?
  let descriptionRaw: String?
  let esrbRating: EsrbRating?

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

  init(id: Int,
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
  var genreTitle: String? {
    guard let genres = genres else { return nil }
    return genres.map({ $0.name }).joined(separator: ", ")
  }

  var publisherTitle: String? {
    guard let publishers = publishers else { return nil }
    return publishers.map({ $0.name }).joined(separator: ", ")
  }

}

struct Publisher: Codable {
  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id, name
  }
}

struct Genre: Codable {
  let id: Int
  let name: String

  enum CodingKeys: String, CodingKey {
    case id, name
  }
}

struct Rating: Codable {
  let id: Int
  let count: Int
  let percent: Double
}

struct EsrbRating: Codable {
  let name: String
}

