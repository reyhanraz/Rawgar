//
//  HomePresenter.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  private var cancellables: Set<AnyCancellable> = []
  
  
  @Published var games: [GameDetailModel] = []
  @Published var error: Error?
  @Published var loadingState: Bool = false
  @Published var homeGrid = [GridItem(.flexible()), GridItem(.flexible())]
  @Published var debouncedText = ""
  @Published var searchText = ""
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
    $searchText
      .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
      .sink(receiveValue: { [weak self] t in
        self?.debouncedText = t
      } )
      .store(in: &cancellables)
  }
  
  func getGames(query: String? = nil, isFavorited: Bool? = nil) {
    loadingState = true
    homeUseCase.getGames(query: query, isFavorited: isFavorited)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          self.loadingState = false
        case .failure(let error):
          self.error = error
        }
      } receiveValue: { value in
        self.games = value
      }.store(in: &cancellables)
  }
  func linkBuilder<Content: View>(
    for game: GameDetailModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: game)) { content() }
  }
}
