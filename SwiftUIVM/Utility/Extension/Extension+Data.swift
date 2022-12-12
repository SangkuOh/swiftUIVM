//
//  Extension+Data.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/12/12.
//

import Foundation

extension Data {
	var prettyPrintedJSONString: String {
		guard
			let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
			let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
			return ""
		}

		return String(decoding: jsonData, as: UTF8.self)
	}
}
