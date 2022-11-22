//
//  RemoteDataSource.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {

  func getGames(query: String?) -> AnyPublisher<[GameDetailResponse], Error>
  func getDetailGames(id: Int) -> AnyPublisher<GameDetailResponse, Error>

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getGames(query: String? = nil) -> AnyPublisher<[GameDetailResponse], Error> {
    return Future<[GameDetailResponse], Error> { completion in
      guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
        completion(.failure(URLError.invalidKey))
        return
      }

      var components = URLComponents(string: Endpoints.Gets.listGames.url)!
      components.queryItems = [
        URLQueryItem(name: "key", value: apiKey),
        URLQueryItem(name: "page", value: "1"),
        URLQueryItem(name: "page_size", value: "20")
      ]

      if let query = query {
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

  func getDetailGames(id: Int) -> AnyPublisher<GameDetailResponse, Error> {
    return Future<GameDetailResponse, Error> { completion in
      guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
        completion(.failure(URLError.invalidKey))
        return
      }

      var components = URLComponents(string: Endpoints.Gets.detailGame(gameId: id).url)!
      components.queryItems = [
        URLQueryItem(name: "key", value: apiKey),
      ]

      guard let url = components.url else {
        completion(.failure(URLError.addressUnreachable(components.url)))
        return
      }
      AF.request(url)
        .validate()
        .responseDecodable(of: GameDetailResponse.self) { response in
          switch response.result {
          case .success(let result):
            completion(.success(result))
          case .failure:
            completion(.failure(URLError.invalidResponse))
          }
        }
    }.eraseToAnyPublisher()
  }
}
