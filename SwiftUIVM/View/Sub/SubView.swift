//
//  SubView.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/30.
//

import SwiftUI

struct SubView: View {
	@EnvironmentObject var navigation: NavigationStore

	@State var item: String = ""

	var body: some View {
		NavigationLink
			.init(item, value: NavigationType.second(item))
	}
}

struct SubView_Previews: PreviewProvider {
	static var previews: some View {
		SubView(item: "preview")
	}
}
