//
//  SwiftUIVMApp.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import SwiftUI

@main
struct SwiftUIVMApp: App {
	@StateObject var store: AppStore = .init()
	@StateObject var navigation: NavigationStore = .init()

	var body: some Scene {
		WindowGroup {
			MainView()
				.environmentObject(store)
				.environmentObject(navigation)
				.onOpenURL {
					navigation.checkLink($0)
				}
		}
	}
}
