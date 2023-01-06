//
//  GetListPresenter.swift
//  
//
//  Created by Reyhan Rifqi on 18/12/22.
//

import SwiftUI
import Combine

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {

  private var cancellables: Set<AnyCancellable> = []

  private let _useCase: Interactor

  @Published public var list: [Response] = []
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  @Published public var debouncedText = ""
  @Published public var searchText = ""

  public init(useCase: Interactor) {
    _useCase = useCase
    $searchText
      .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
      .sink(receiveValue: { [weak self] t in
        self?.debouncedText = t
      })
      .store(in: &cancellables)
  }

  public func getList(request: Request?) {
    isLoading = true
    _useCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { list in
        self.list = list
      })
      .store(in: &cancellables)
  }
}
