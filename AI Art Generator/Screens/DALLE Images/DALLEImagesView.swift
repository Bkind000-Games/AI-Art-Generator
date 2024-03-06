//
//  ContentView.swift
//  AI Art Generator
//
//  Created by Kind, Braeden on 2/27/24.
//

import SwiftUI

struct DALLEImagesView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if !vm.urls.isEmpty {
                    HStack {
                        ForEach(vm.dalleImages) {dalleImage in
                            if let uiImage = dalleImage.uiImage {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .onTapGesture {
                                        vm.selectedImage = uiImage
                                    }
                            } else {
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
                if !vm.fetching {
                    if !vm.urls.isEmpty {
                        Text("Select an Image to View:")
                    }
                    if let selectedImage = vm.selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 256, height: 256)
                    }
                    if vm.urls.isEmpty {
                        Text("The more descriptive you are, the better the results, and vice versa!")
                        TextField("Image Description....",text: $vm.prompt,axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        Form {
                            Text("If the response your looking for is not listed, you can always leave it none and type it in the description box.")
                            Picker("Image Style",selection: $vm.imageStyle) {
                                ForEach(ImageStyle.allCases, id: \.self) { imageStyle in
                                    Text(imageStyle.rawValue)
                                }
                            }
                            Picker("Image Medium",selection: $vm.imageMedium) {
                                ForEach(ImageMedium.allCases, id: \.self) { imageMedium in
                                    Text(imageMedium.rawValue)
                                }
                            }
                            Picker("Artist",selection: $vm.artist) {
                                ForEach(Artist.allCases, id: \.self) { artist in
                                    Text(artist.rawValue)
                                }
                            }
                            HStack {
                                Spacer()
                                Button("Fetch Images") {
                                    vm.fetchImages()
                                }
                                .disabled(vm.prompt.isEmpty)
                                .buttonStyle(.borderedProminent)
                            }
                            HStack {
                                Spacer()
                                if vm.urls.isEmpty || vm.selectedImage == nil {
                                    Image("Artist")
                                }
                                Spacer()
                            }
                        }
                    } else {
                        Text("Your Description: " + vm.description)
                            .padding()
                        HStack {
                            Button("Get Variations") {
                                vm.fetchVariations()
                            }
                                .disabled(vm.selectedImage == nil)
                            Button("Go Back") {
                                vm.reset()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    ProgressView()
                }
                if vm.selectedImage == nil && !vm.urls.isEmpty {
                    Image("Artist")
                }
                Spacer()
            }
            .navigationTitle("Art Generator")
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct DALLEImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DALLEImagesView()
    }
}
