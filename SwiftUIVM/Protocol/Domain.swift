//
//  Domain.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/30.
//

import Foundation

protocol Domain {
	associatedtype Response

	mutating func toDomain(_ response: Response)
}
