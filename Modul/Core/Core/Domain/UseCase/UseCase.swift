//
//  File.swift
//  
//
//  Created by Reyhan Rifqi on 18/12/22.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
