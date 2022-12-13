//
//  Extension+URLRequest.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/12/13.
//

import Foundation

internal extension URLRequest {
	mutating func encoded(
		encodable: Encodable,
		encoder: JSONEncoder = JSONEncoder()
	) -> Data? {
		let encodable = AnyEncodable(encodable)
		return try? encoder.encode(encodable)
	}
}

