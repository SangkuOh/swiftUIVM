//
//  Logger.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//
import Foundation

class NetworkLogger {
	static func log(request: URLRequest) {
		print("\n\n - - - - - - - - - - [[ 🙏🏻🙏🏻🙏🏻🙏🏻 URLRequest 🙏🏻🙏🏻🙏🏻🙏🏻 ]] - - - - - - - - - - \n")

		let urlAsString = request.url?.absoluteString ?? ""
		let urlComponents = URLComponents(string: urlAsString)
		let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
		let path = "\(urlComponents?.path ?? "")"
		let query = "\(urlComponents?.query ?? "")"
		let host = "\(urlComponents?.host ?? "")"
		var output = """
			\(urlAsString)
			\(method) \(path)?\(query) HTTP/1.1
			HOST: \(host)\n
		"""

		output += "\n-- Request Header --\n"
		for (key, value) in request.allHTTPHeaderFields ?? [:] {
			output += "\(key): \(value) \n"
		}

		output += "\n-- Request Body --\n"
		if let body = request.httpBody {
			if let bodyStr = String(data: body, encoding: .utf8) {
				output += "\(bodyStr)"
			} else {
				output += "\(body)"
			}
		} else {
			output += "NONE"
		}
		output += "\n"
		print(output)
	}

	static func log(response: HTTPURLResponse?, data: Data?, error: Error? = nil) {
		print("\n\n - - - - - - - - - - [[ 🎉🎉🎉🎉 URLResponse 🎉🎉🎉🎉 ]] - - - - - - - - - - \n")

		let urlString = response?.url?.absoluteString
		let components = NSURLComponents(string: urlString ?? "")
		let path = "\(components?.path ?? "")"
		let query = "\(components?.query ?? "")"
		var output = ""

		if let statusCode = response?.statusCode {
			output += "HTTP \(statusCode) \(path)?\(query)\n"
		}

		if let data {
			output += "\n-- Response body --\n"
			output += "\(String(data: data, encoding: .utf8) ?? "")"
		}

		if let error {
			output += "\nError: \(error.localizedDescription)"
		}
		print(output)
	}
}
