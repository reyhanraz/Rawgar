//
//  FavoriteView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI

struct FavoriteView: View {
  @StateObject var presenter: FavoritePresenter
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        if presenter.games.count == 0 {
          EmptyView()
        } else {
          ScrollView {
            LazyVStack(spacing: 16) {
              ForEach(presenter.games, id: \.id) { game in
                self.presenter.linkBuilder(for: game) {
                  FavoriteGameView(game: game)
                }.buttonStyle(PlainButtonStyle())
              }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
          }
        }
      }
    }

    .background(Color.CustomDarkPurple)
    .onAppear {
      self.presenter.getFavoriteGames()
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
    .navigationTitle("Favorite")
    .navigationBarTitleDisplayMode(.automatic)
  }
}

