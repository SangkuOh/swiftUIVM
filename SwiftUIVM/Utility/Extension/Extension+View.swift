//
//  View.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/12/06.
//

import SwiftUI

//MARK: Environment
extension View {
	func containerServiceMock() -> some View {
		environment(\.containerService, ContainerServiceMock())
	}
}
