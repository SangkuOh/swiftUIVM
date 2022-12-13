//
//  ContainerService.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import Foundation
import UIKit.UIImage

protocol ContainerService {
	func getStringContainer() async -> Result<StringItemResponse, RequestError>
}

struct ContainerServiceLive: HTTPClient, ContainerService {
	func getStringContainer() async -> Result<StringItemResponse, RequestError> {
		.success(.init(items: ["라이브"]))
	}
}

struct ContainerServiceMock: ContainerService {
	let getStringContainerResult: Result<StringItemResponse, RequestError>

	init (
		getStringContainerResult: Result<StringItemResponse, RequestError> = .failure(.noResponse)
	) {
		self.getStringContainerResult = getStringContainerResult
	}

	func getStringContainer() async -> Result<StringItemResponse, RequestError> {
		getStringContainerResult
	}
}


protocol ImageService {
	func sendImage(images: [UIImage]) async -> Result<StringItemResponse, RequestError>
}

struct ImageServiceLive: MultipartHTTPClient, ImageService {
	func sendImage(images: [UIImage]) async -> Result<StringItemResponse, RequestError> {
		await sendMultipartRequest(endpoint: ContainerEndpoint.string(""), imageDatas: images.map{ $0.jpegData(compressionQuality: 1.0)! }, responseModel: StringItemResponse.self)
	}
}
