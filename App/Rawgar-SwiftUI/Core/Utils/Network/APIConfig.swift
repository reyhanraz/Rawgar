//
//  APIConfig.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation

struct API {
  
  static let baseUrl = "https://api.rawg.io/api/"
  
}

protocol Endpoint {
  
  var url: String { get }
  
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case listGames
    case detailGame
    
    public var url: String {
      switch self {
      case .listGames: return "\(API.baseUrl)games"
      case .detailGame: return "\(API.baseUrl)games/"
      }
    }
  }
}
