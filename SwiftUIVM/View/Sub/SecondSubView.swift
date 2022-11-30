//
//  SecondSubView.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/30.
//

import SwiftUI

struct SecondSubView: View {
	@EnvironmentObject var navigation: NavigationStore

	@State var item: String = ""

	var body: some View {
		VStack {
			Text("\(item)`s second subview")
				.font(.title)

			Button {
				navigation.dismissPaths()
			} label: {
				Text("Go to root")
					.font(.title)
			}
			.buttonStyle(.borderedProminent)
		}
	}
}

struct SecondSubView_Previews: PreviewProvider {
	static var previews: some View {
		SecondSubView(item: "preview")
			.environmentObject(NavigationStore())
	}
}
