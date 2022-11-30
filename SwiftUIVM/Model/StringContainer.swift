//
//  StringContainer.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

struct StringContainer: Container {
	typealias Item = String

	var items: [Item]
	var count: Int { items.count }

	mutating func push(_ item: Item) {
		items.append(item)
	}

	mutating func append(_ item: Item) {
		self.push(item)
	}

	subscript(i: Int) -> Item { items[i] }

	mutating func toDomain(_ response: StringItemResponse) {
		items = response.items
	}
}
