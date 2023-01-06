//
//  LocaleDataSource.swift
//  
//
//  Created by Reyhan Rifqi on 18/12/22.
//

import Combine

public protocol LocaleDataSource: DataSource {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
  func add(entities: Response) -> AnyPublisher<Bool, Error>
//    func get(id: String) -> AnyPublisher<Response, Error>
//    func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
  func updateFavoriteGames(by gameId: Int) -> AnyPublisher<Response, Error>
}
