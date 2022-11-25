//
//  Live.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import SwiftUI

struct ContainerServiceKey: EnvironmentKey {
	static let defaultValue: ContainerService = ContainerServiceLive()
	static let mock: ContainerService = ContainerServiceMock()
}

extension EnvironmentValues {
	var containerService: ContainerService {
		get { self[ContainerServiceKey.self] }
		set { self[ContainerServiceKey.self]  = newValue }
	}
}

extension View {
	func containerService(_ containerService: ContainerService) -> some View {
		environment(\.containerService, containerService)
	}
}
