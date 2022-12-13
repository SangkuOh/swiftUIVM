//
//  TestRequest.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/12/13.
//

import Foundation

struct TestRequest: Encodable {
	var name: String = "hello world"
	var sub: SubStruct = .init()
}

struct SubStruct: Encodable {
	var id: UUID = .init()
}
