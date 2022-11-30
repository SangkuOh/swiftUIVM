//
//  ContainerService.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import Foundation

protocol ContainerService {
	func getStringContainer() async -> Result<StringItemResponse, RequestError>
}

struct ContainerServiceLive: ContainerService {
	func getStringContainer() async -> Result<StringItemResponse, RequestError> {
		.success(.init(items: ["라이브"]))
	}
}

struct ContainerServiceMock: ContainerService {
	let getStringContainerResult: Result<StringItemResponse, RequestError> = .failure(.noResponse)

	func getStringContainer() async -> Result<StringItemResponse, RequestError> {
		getStringContainerResult
	}
}
