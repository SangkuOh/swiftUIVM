//
//  Container.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import Foundation

protocol Container {
	associatedtype Item
	associatedtype Response

	mutating func append(_ item: Item)
	var count: Int { get }
	subscript(i: Int) -> Item { get }

	mutating func toDomain(_ response: Response)
}
