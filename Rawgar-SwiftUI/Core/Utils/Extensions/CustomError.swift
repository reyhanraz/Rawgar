//
//  CustomError.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import Foundation

enum URLError: LocalizedError {
  
  case invalidResponse
  case addressUnreachable(URL?)
  case invalidKey
  case noGameFound
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url?.absoluteString ?? "") is unreachable."
    case .invalidKey: return "No API_KEY provided"
    case .noGameFound: return "No Game Found"
    }
  }
  
}

enum DatabaseError: LocalizedError {
  
  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
