//
//  Logger.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//
import Foundation

import Foundation

class NetworkLogger {
	static func log(request: URLRequest) {
		print("\n\n - - - - - - - - - - [[ ⬆️⬆️⬆️ URLRequest Log Start ⬆️⬆️⬆️ ]] - - - - - - - - - - \n")

		guard
			let urlAsString = request.url?.absoluteString,
			let method = request.httpMethod else {
			return
		}

		let urlComponents = URLComponents(string: urlAsString)

		guard
			let host = urlComponents?.host,
			let path = urlComponents?.path else {
			return
		}

		let query = urlComponents?.query ?? ""

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
			output += body.prettyPrintedJSONString
		} else {
			output += "NONE"
		}
		output += "\n"
		print(output)
	}

	static func log(response: HTTPURLResponse?, data: Data?, error: Error? = nil) {
		print("\n\n - - - - - - - - - - [[ ⬇️⬇️⬇️ URLResponse Log Start ⬇️⬇️⬇️ ]] - - - - - - - - - - \n")

		guard
			let urlString = response?.url?.absoluteString,
			let components = URLComponents(string: urlString) else {
			return
		}

		let path = components.path
		let query = components.query ?? ""
		var output = ""

		if let statusCode = response?.statusCode {
			let emoji = statusCode == 200 ? "✅" : "🚨"
			output += "\(emoji) HTTP \(statusCode) \(path)?\(query)\n"
		}

		if let data {
			output += "\n-- Response body --\n"
			output += data.prettyPrintedJSONString
		}

		if let error {
			output += "\nError: \(error.localizedDescription)"
		}
		print(output)
	}
}
