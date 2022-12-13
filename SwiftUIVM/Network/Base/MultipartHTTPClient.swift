//
//  MultipartHTTPClient.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/12/13.
//

import Foundation

protocol MultipartHTTPClient {
	typealias Parameters = [String: String]

	func sendMultipartRequest<T: Decodable>(
		endpoint: Endpoint,
		images: [Data]?,
		responseModel: T.Type
	) async -> Result<T, RequestError>
}

extension MultipartHTTPClient {
	func sendMultipartRequest<T: Decodable>(
		endpoint: Endpoint,
		images: [Data]? = nil,
		responseModel: T.Type
	) async -> Result<T, RequestError> {
		var urlComponents = URLComponents()
		urlComponents.scheme = endpoint.scheme
		urlComponents.host = endpoint.host
		urlComponents.path = endpoint.path

		guard let url = urlComponents.url else {
			return .failure(.invalidURL)
		}

		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue

		let boundary = "Boundary-\(UUID().uuidString)"
		request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

		var httpBody = Data()
		if let body = endpoint.body as? Parameters {
			for (key, value) in body {
				httpBody.appendString(
					convertFormField(
						named: key,
						value: value,
						using: boundary
					)
				)
			}
		}

		if let images = images {
			for image in images {
				httpBody.append(
					convertFileData(
						fieldName: "file",
						fileName: "\(Date().timeIntervalSince1970)_photo.jpg",
						mimeType: "multipart/form-data",
						fileData: image,
						using: boundary
					)
				)
			}
		}

		httpBody.appendString("--\(boundary)--")
		request.httpBody = httpBody

		NetworkLogger.log(request: request)

		do {
			let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
			NetworkLogger.log(response: response as? HTTPURLResponse, data: data)
			guard let response = response as? HTTPURLResponse else {
				return .failure(.noResponse)
			}
			switch response.statusCode {
			case 200...299:
				guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
					return .failure(.decode)
				}
				return .success(decodedResponse)

			case 401:
				return .failure(.unauthorized)

			default:
				return .failure(.unexpectedStatusCode)
			}
		} catch {
			print(error)
			return .failure(.unknown)
		}
	}
}

// MARK: Private
extension MultipartHTTPClient {
	private func convertFormField(
		named name: String,
		value: String,
		using boundary: String
	) -> String {
		var fieldString = "--\(boundary)\r\n"
		fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
		fieldString += "\r\n"
		fieldString += "\(value)\r\n"

		return fieldString
	}

	private func convertFileData(
		fieldName: String,
		fileName: String,
		mimeType: String,
		fileData: Data,
		using boundary: String
	) -> Data {
		var data = Data()
		data.appendString("--\(boundary)\r\n")
		data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
		data.appendString("Content-Type: \(mimeType)\r\n\r\n")
		data.append(fileData)
		data.appendString("\r\n")

		return data
	}
}

extension Data {
	mutating func appendString(_ string: String) {
		if let data = string.data(using: .utf8) {
			self.append(data)
		}
	}
}
