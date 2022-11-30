//
//  NavigationStore.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/30.
//

import SwiftUI

class NavigationStore: ObservableObject {
	@Published var subviewPath: [NavigationType] = []
}

//MARK: dismiss branchs
extension NavigationStore {
	func dismissPaths() {
		subviewPath.removeAll()
	}
}

//MARK: Deep Link
extension NavigationStore {
	func checkLink(_ url: URL) {
		subviewPath.append(.second("live"))
	}
}

// MARK: NavigationType
enum NavigationType: Hashable {
	case first(String)
	case second(String)
}
