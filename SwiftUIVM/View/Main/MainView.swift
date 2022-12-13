//
//  ContentView.swift
//  SwiftUIVM
//
//  Created by sangku on 2022/11/25.
//

import SwiftUI
import PhotosUI

struct MainView: View {
	// Dependency
	@Environment(\.containerService) var containerService
	@Environment(\.imageService) var imageService

	// Stores shared states
	@EnvironmentObject var store: AppStore
	@EnvironmentObject var navigation: NavigationStore

	// UI State
	@State var container: StringContainer = .init(items: [])

	// Error
	@State var error: RequestError? = nil
	@State var isError: Bool = false
	@State var photos: [PhotosPickerItem] = []
	@State var images: [UIImage] = []

	@ViewBuilder
	var body: some View {
		NavigationStack(path: $navigation.subviewPath) {
			PhotosPicker("Photos", selection: $photos)
				.buttonStyle(.borderedProminent)
			Button {
				Task {
					await imageService.sendImage(images: self.images)
				}
			} label: {
				Text("Send Test")
			}
			List(images, id: \.self) { uiImage in
				if let uiImage = uiImage {
					Image
						.init(uiImage: uiImage)
						.resizable()
						.scaledToFit()
				} else {
					Text("empty")
				}
			}
			.navigationTitle("Main")
		}
		.task { await getContainer() }
		.alert(isPresented: $isError) {
			.init(
				title: .init("Error"),
				message: .init(error?.customMessage ?? "no message")
			)
		}
		.onChange(of: photos) { newValue in
			newValue.forEach {
				$0.loadTransferable(type: Data.self) { result in
					switch result {
					case .success(let imageData):
						guard
							let imageData = imageData,
							let uiImage = UIImage(data: imageData)
						else {
							return
						}
						self.images.append(uiImage)
					case .failure:
						return
					}
				}
			}
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
			.environmentObject(AppStore())
			.environmentObject(NavigationStore())
			.containerServiceMock(
				.init(
					getStringContainerResult: .success(
						.init(
							items: ["하나", "둘", "셋", "넷"]
						)
					)
				)
			)
	}
}
