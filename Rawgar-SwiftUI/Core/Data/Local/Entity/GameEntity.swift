//
//  GameEntity.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import RealmSwift

class GameEntity: Object {

  @objc dynamic var descriptionRaw: String = ""
  @objc dynamic var gameID: Int = 0
  @objc dynamic var image: String = ""
  @objc dynamic var metacritics: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var released: String = ""
  @objc dynamic var reviewsCount: Int = 0
  @objc dynamic var rating: Double = 0
  var ratings = List<RatingEntity>()
  @objc dynamic var publisherTitles: String = ""
  @objc dynamic var genreTitles: String = ""
  @objc dynamic var esrbRating: String = ""
  @objc dynamic var isFavorited: Bool = false
  @objc dynamic var dateAdded: Date?

  override static func primaryKey() -> String? {
    return "gameID"
  }

}

class RatingEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var gameID: Int = 0
  @objc dynamic var ratingID: Int = 0
  @objc dynamic var ratingCount: Int = 0
  @objc dynamic var ratingPercent: Double = 0

  override static func primaryKey() -> String? {
    return "id"
  }
}
