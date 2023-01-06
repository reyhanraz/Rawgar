//
//  CustomError+Ext.swift
//  
//
//  Created by Reyhan Rifqi on 18/12/22.
//

import Foundation

public enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL?)
  case invalidKey
  case noGameFound
  case invalidRequest

  public var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url?.absoluteString ?? "") is unreachable."
    case .invalidKey: return "No API_KEY provided"
    case .noGameFound: return "No Game Found"
    case .invalidRequest: return "Invalid Request"
    }
  }

}

public enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed

  public var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
