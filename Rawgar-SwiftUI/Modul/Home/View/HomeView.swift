//
//  HomeView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI

struct HomeView: View {
  @StateObject var presenter: HomePresenter
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        ScrollView {
          LazyVGrid(columns: self.presenter.homeGrid) {
            ForEach(presenter.games, id: \.id) { game in
              self.presenter.linkBuilder(for: game) {
                GameRow(game: game)
              }.buttonStyle(PlainButtonStyle())
            }
          }
          .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
      }
    }
    .background(Color.CustomDarkPurple)
    .searchable(text: $presenter.searchText, prompt: "Search Games")
    .onReceive(presenter.$debouncedText) { (val) in
      if !val.isEmpty{
        self.presenter.getGames(query: val)
      } else {
        self.presenter.getGames()
      }
    }
    .alert(
      "Error",
      isPresented: .constant($presenter.error.wrappedValue != nil),
      presenting: $presenter.error.wrappedValue
    ) { details in
      Button("OK", role: .cancel) {
        self.presenter.error = nil
      }
    } message: { details in
      Text(details.localizedDescription)
    }
    .navigationTitle("Games")
    .navigationBarTitleDisplayMode(.automatic)
  }
}
