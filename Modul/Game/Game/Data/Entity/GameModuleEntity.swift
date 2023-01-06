//
//  GameModuleEntity.swift
//  Game
//
//  Created by Reyhan Rifqi on 27/12/22.
//

import Foundation
import RealmSwift

public class GameModuleEntity: Object {

  @objc public dynamic var descriptionRaw: String = ""
  @objc public dynamic var gameID: Int = 0
  @objc public dynamic var image: String = ""
  @objc public dynamic var metacritics: Int = 0
  @objc public dynamic var name: String = ""
  @objc public dynamic var released: String = ""
  @objc public dynamic var reviewsCount: Int = 0
  @objc public dynamic var rating: Double = 0
  public var ratings = List<RatingModuleEntity>()
  @objc public dynamic var publisherTitles: String = ""
  @objc public dynamic var genreTitles: String = ""
  @objc public dynamic var esrbRating: String = ""
  @objc public dynamic var isFavorited: Bool = false
  @objc public dynamic var dateAdded: Date?

  public override static func primaryKey() -> String? {
    return "gameID"
  }

}

public class RatingModuleEntity: Object {
  @objc public dynamic var id: String = ""
  @objc public dynamic var gameID: Int = 0
  @objc public dynamic var ratingID: Int = 0
  @objc public dynamic var ratingCount: Int = 0
  @objc public dynamic var ratingPercent: Double = 0

  public override static func primaryKey() -> String? {
    return "id"
  }
}
