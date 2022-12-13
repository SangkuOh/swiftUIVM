//
//  Container.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import Foundation

enum ContainerEndpoint {
	case string(String)
	case test(TestRequest)
}

extension ContainerEndpoint: Endpoint {
	var path: String {
		switch self {
		case .string(let word):
			return "/string/\(word)"

		case .test:
			return "/string/"
		}
	}

	var method: RequestMethod {
		switch self {
		case .string:
			return .get

		case .test:
			return .post
		}
	}

	var header: [String: String]? {
		switch self {
		default:
			return [
				"key": "value"
			]
		}
	}

	var body: Encodable? {
		switch self {
		case .string:
			return nil

		case .test(let params):
			return params
		}
	}
}
