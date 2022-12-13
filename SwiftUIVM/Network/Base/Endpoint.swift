//
//  Endpoint.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import Foundation

protocol Endpoint {
	var scheme: String { get }
	var host: String { get }
	var path: String { get }
	var method: RequestMethod { get }
	var header: [String: String]? { get }
	var body: [String: Any]? { get }
}

extension Endpoint {
	var scheme: String {
		"https"
	}

	var host: String {
		"baseURl.com"
	}
}
