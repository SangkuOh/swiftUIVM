//
//  View.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/12/06.
//

import SwiftUI

//MARK: Environment
extension View {
	func containerServiceMock(_ containerService: ContainerServiceMock = .init()) -> some View {
		environment(\.containerService, containerService)
	}
}
