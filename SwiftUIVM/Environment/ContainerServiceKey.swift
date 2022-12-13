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


struct ImageServiceKey: EnvironmentKey {
	static let defaultValue: ImageService = ImageServiceLive()
}

extension EnvironmentValues {
	var imageService: ImageService {
		get { self[ImageServiceKey.self] }
		set { self[ImageServiceKey.self]  = newValue }
	}
}
