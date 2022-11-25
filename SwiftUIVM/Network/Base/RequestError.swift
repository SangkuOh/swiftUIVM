//
//  RequestError.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import Foundation

public enum RequestError: Error, LocalizedError {
	case decode
	case invalidURL
	case noResponse
	case unauthorized
	case unexpectedStatusCode
	case unknown

	var customMessage: String {
		switch self {
		case .decode:
			return "Decode error"
			
		case .unauthorized:
			return "Session expired"

		case .noResponse:
			return "no response"

		default:
			return "Unknown error"
		}
	}
}

