//
//  ContentView.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import SwiftUI

struct MainView: View {
	// Dependency
	@Environment(\.containerService) var containerService

	// Stores shared states
	@EnvironmentObject var store: AppStore
	@EnvironmentObject var navigation: NavigationStore

	// UI State
	@State var container: StringContainer = .init(items: [])

	// Error
	@State var error: RequestError? = nil
	@State var isError: Bool = false

	@ViewBuilder
	var body: some View {
		NavigationStack(path: $navigation.subviewPath) {
			List(container.items, id: \.self) {
				NavigationLink
					.init($0, value: NavigationType.first($0))
			}
			.navigationDestination(for: NavigationType.self) { type in
				switch type {
				case let .first(item):
					SubView(item: item)

				case let .second(item):
					SecondSubView(item: item)
				}
			}
			.navigationTitle("Main")
		}
		.task { await getContainer() }
		.alert(isPresented: $isError) {
			.init(
				title: .init("Error"),
				message: .init(error?.customMessage ?? "no message")
			)
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.environmentObject(AppStore())
			.environmentObject(NavigationStore())
		//					.containerServiceMock()
	}
}
