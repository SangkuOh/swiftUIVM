//
//  AnyEncodable.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/12/13.
//

struct AnyEncodable: Encodable {
	private let encodable: Encodable

	init(_ encodable: Encodable) {
		self.encodable = encodable
	}

	func encode(to encoder: Encoder) throws {
		try encodable.encode(to: encoder)
	}
}
