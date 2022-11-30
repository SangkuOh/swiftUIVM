//
//  ContentView+Logic.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

extension MainView {
	func getContainer() async {
		let response = await containerService.getStringContainer()
		switch response {
		case .success(let success):
			container.toDomain(success)

		case .failure(let error):
			self.error = error
			self.isError = true
		}
	}
}
