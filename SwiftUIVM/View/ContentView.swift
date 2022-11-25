//
//  ContentView.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.containerService) var containerService

	@State var container: StringContainer = .init(items: [])

	@State var error: RequestError? = nil
	@State var isError: Bool = false

	var body: some View {
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.accentColor)
			Text("Hello, world!")
			List(container.items, id: \.self) {
				Text($0)
			}
		}
		.padding()
		.task { await getContainer() }
		.alert(isPresented: $isError) {
			.init(
				title: .init("Error"),
				message: .init(error?.customMessage ?? "no message")
			)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
//			.containerServiceMock()
	}
}
