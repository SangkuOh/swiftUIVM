//
//  Container.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

enum ContainerEndpoint {
	case string(String)
}

extension ContainerEndpoint: Endpoint {
	var path: String {
		switch self {
		case .string(let word):
			return "/string/\(word)"
		}
	}

	var method: RequestMethod {
		switch self {
		case .string:
			return .get
		}
	}

	var header: [String: String]? {
		let token = "token"
		switch self {
		case .string:
			return [
				"token": token
			]
		}
	}

	var body: [String: String]? {
		switch self {
		case .string:
			return nil
		}
	}
}

