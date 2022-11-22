//
//  DetailGameView.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 17/11/22.
//

import SwiftUI

struct DetailGameView: View {
  @StateObject var presenter: DetailGamePresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        DetailGameVw(game: presenter.game)
      }
    }
    .onAppear {
      self.presenter.getGames()
    }
    .navigationTitle(presenter.game?.name ?? "")
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        Button {
          self.presenter.updateFavorites()
        } label: {
          Image(systemName: presenter.isFavorited ?? false ? "heart.fill" : "heart")
        }
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
  }
}
