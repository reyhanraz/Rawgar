//
//  DetailGameVw.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 22/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailGameVw: View {
  let game: GameDetailModel?
  var body: some View {
    ScrollView{
      VStack{
        imageCategory
        gameContent
      }
      .frame(width: UIScreen.main.bounds.width)
    }
    .background(Color.CustomDarkPurple)
  }
}

extension DetailGameVw {
  var imageCategory: some View {
    WebImage(url: URL(string: game?.backgroundImage ?? ""))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(height: UIScreen.main.bounds.width*3/4)
  }
  
  var gameContent: some View{
    VStack(alignment: .leading, spacing: 20){
      Text("About")
        .font(.system(size: 18, weight: .bold))
        .foregroundColor(.CustomWhite)
      Text(game?.descriptionRaw ?? "")
        .font(.system(size: 16))
        .foregroundColor(.CustomWhite)
      gameDetailAttribute
      totalRatingView
    }
    .padding(16)
  }
  
  var gameDetailAttribute: some View{
    VStack(spacing: 16){
      TitleBodyLabel(title: "Metascore", desc: "\(game?.metacritic ?? 0)")
      TitleBodyLabel(title: "Genre", desc: "\(game?.genres ?? "-")")
      TitleBodyLabel(title: "Released", desc: "\(game?.released ?? "-")")
      TitleBodyLabel(title: "Publisher", desc: "\(game?.publishers ?? "-")")
      TitleBodyLabel(title: "Age Rating", desc: "\(game?.esrbRating ?? "-")")
    }
  }
  
  var totalRatingView: some View {
    VStack{
      HStack{
        Image(systemName: "star.fill")
          .frame(width: 24, height: 24)
          .font(.system(size: 20))
          .foregroundColor(Color.CustomWhite)
        Text("\(game?.rating ?? 0, specifier: "%.2f")/5")
          .foregroundColor(Color.CustomWhite)
          .font(.system(size: 18))
        Spacer()
        Text("\(game?.reviewsCount ?? 0)")
          .foregroundColor(Color.CustomWhite)
          .font(.system(size: 14))
      }
      
      ForEach(game?.ratings?.sorted(by: { lhs, rhs in
        lhs.id > rhs.id
      }) ?? []) { rating in
        RatingProgressView(starId: rating.id, percentage: rating.percent, ratingCount: rating.count)
        
      }
    }
    .background(Color.CustomDarkPurple)
  }
}

struct DetailGameVw_Previews: PreviewProvider {
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
                               descriptionRaw: "The third game in a series, it holds nothing back from the player. Open world adventures of the renowned monster slayer Geralt of Rivia are now even on a larger scale. Following the source material more accurately, this time Geralt is trying to find the child of the prophecy, Ciri while making a quick coin from various contracts on the side. Great attention to the world building above all creates an immersive story, where your decisions will shape the world around you.\n\nCD Project Red are infamous for the amount of work they put into their games, and it shows, because aside from classic third-person action RPG base game they provided 2 massive DLCs with unique questlines and 16 smaller DLCs, containing extra quests and items.\n\nPlayers praise the game for its atmosphere and a wide open world that finds the balance between fantasy elements and realistic and believable mechanics, and the game deserved numerous awards for every aspect of the game, from music to direction.",
                               esrbRating: "",
                               isFavorited: true)
    DetailGameVw(game: game)
  }
}
