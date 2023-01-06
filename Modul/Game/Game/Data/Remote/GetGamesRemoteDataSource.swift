//
//  GetGamesRemoteDataSource.swift
//  Game
//
//  Created by Reyhan Rifqi on 30/12/22.
//

import Core
import Combine
import Foundation
import Alamofire

public struct GetGamesRemoteDataSource: DataSource {
  public typealias Request = GameListRequest

  public typealias Response = [GameDetailResponse]

  private let _endpoint: String

  public init(endpoint: String) {
    self._endpoint = endpoint
  }

  public func execute(request: GameListRequest?) -> AnyPublisher<[GameDetailResponse], Error> {
    return Future<[GameDetailResponse], Error> { completion in
      guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
        completion(.failure(URLError.invalidKey))
        return
      }

      var components = URLComponents(string: _endpoint)!
      components.queryItems = [
        URLQueryItem(name: "key", value: apiKey),
        URLQueryItem(name: "page", value: "1"),
        URLQueryItem(name: "page_size", value: "20")
      ]

      if let query = request?.searchQuery {
        components.queryItems?.append(URLQueryItem(name: "search", value: query))
      }

      guard let url = components.url else {
        completion(.failure(URLError.addressUnreachable(components.url)))
        return
      }

      AF.request(url)
        .validate()
        .responseDecodable(of: GamesResponse.self) { response in
          switch response.result {
          case .success(let value):
            if value.results.count == 0 {
              completion(.failure(URLError.noGameFound))
            } else {
              completion(.success(value.results))
            }
          case .failure:
            completion(.failure(URLError.invalidResponse))
          }
        }
    }.eraseToAnyPublisher()
  }

}
