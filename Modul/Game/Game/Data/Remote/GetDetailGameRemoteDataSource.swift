//
//  GetDetailGameRemoteDataSource.swift
//  Game
//
//  Created by Reyhan Rifqi on 04/01/23.
//

import Core
import Combine
import Foundation
import Alamofire

public struct GetDetailGameRemoteDataSource: DataSource {

  public typealias Request = Int

  public typealias Response = GameDetailResponse

  private let _endpoint: String

  public init(endpoint: String) {
    self._endpoint = endpoint
  }

  public func execute(request: Int?) -> AnyPublisher<GameDetailResponse, Error> {
    return Future<GameDetailResponse, Error> { completion in
      guard let request = request else {
        completion(.failure(URLError.invalidRequest))
        return
      }
      guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
        completion(.failure(URLError.invalidKey))
        return
      }

      var components = URLComponents(string: "\(_endpoint)\(request)")!
      components.queryItems = [
        URLQueryItem(name: "key", value: apiKey)
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
