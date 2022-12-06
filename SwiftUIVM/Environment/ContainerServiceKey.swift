//
//  Live.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import SwiftUI

struct ContainerServiceKey: EnvironmentKey {
	static let defaultValue: ContainerService = ContainerServiceLive()
}

extension EnvironmentValues {
	var containerService: ContainerService {
		get { self[ContainerServiceKey.self] }
		set { self[ContainerServiceKey.self]  = newValue }
	}
}
