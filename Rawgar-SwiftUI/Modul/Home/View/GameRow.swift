//
//  GameRow.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 15/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
  var game: GameDetailModel
  
  var body: some View {
    VStack(spacing: 0) {
      imageCategory
      content
        .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
    }
    .frame(width: UIScreen.main.bounds.width/2 - 16, height: (UIScreen.main.bounds.width/2)*3/4 + 100)
    .background(Color.CustomDarkPurple)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(Color.CustomBorderColor, lineWidth: 2)
    )
  }
}

extension GameRow {
  
  var imageCategory: some View {
    WebImage(url: URL(string: game.backgroundImage ?? ""))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(height: 150)
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(game.name ?? "")
        .font(.system(size: 16))
        .foregroundColor(.CustomWhite)
        .bold()
        .lineLimit(2)
        .fixedSize(horizontal: false, vertical: true)
      Spacer()
      
      detailContent
      
    }
  }
  
  var detailContent: some View {
    HStack {
      Text(game.released ?? "")
        .font(.system(size: 14))
        .lineLimit(2)
        .foregroundColor(.CustomWhite)
      
      Spacer()
      
      HStack(spacing: 4) {
        Text(Image(systemName: "star.fill"))
          .font(.system(size: 14))
          .foregroundColor(.CustomWhite)
        Text("\(game.rating ?? 0, specifier: "%.2f")")
          .font(.system(size: 14))
          .foregroundColor(.CustomWhite)
      }
    }
  }
}

struct GameRow_Previews: PreviewProvider {
  static var previews: some View {
    let game = GameDetailModel(id: 3328,
                               name: "The Witcher 3: Wild Hunt",
                               metacritic: 92,
                               released: "2015-05-18",
                               backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
                               rating: 4.67,
                               ratings: [
                                RatingModel(id: 5, count : 4443, percent : 78.03),
                                RatingModel(id: 4, count : 887, percent : 15.58),
                                RatingModel(id: 3, count : 226, percent : 3.97),
                                RatingModel(id: 2, count : 0, percent : 0),
                                RatingModel(id: 1, count : 138, percent : 2.42),
                               ],
                               reviewsCount: 5694,
                               publishers: "CD PROJEKT RED",
                               genres: "Action, Adventure, RPG",
                               descriptionRaw: "The third game in a series, it holds nothing back from the player. Open world adventures of the renowned monster slayer Geralt of Rivia are now even on a larger scale. Following the source material more accurately, this time Geralt is trying to find the child of the prophecy, Ciri while making a quick coin from various contracts on the side. Great attention to the world building above all creates an immersive story, where your decisions will shape the world around you.\n\nCD Project Red are infamous for the amount of work",
                               esrbRating: "", isFavorited: false)
    GameRow(game: game)
  }
}

