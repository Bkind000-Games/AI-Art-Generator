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
                            } else {
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
                if !vm.fetching {
                    if vm.urls.isEmpty {
                        Text("The more descriptive you can be, the better the results!")
                        TextField("Image Description....",text: $vm.prompt,axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        Button("Fetch Images") {
                            vm.fetchImages()
                        }
                        .disabled(vm.prompt.isEmpty)
                        .buttonStyle(.borderedProminent)
                    } else {
                        Button("Try another") {
                            vm.clearProperties()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    ProgressView()
                }
                Spacer()
            }
            .navigationTitle("Art Generator")
        }
    }
}

struct DALLEImagesView_Previews: PreviewProvider {
    static var previews: some View {
        DALLEImagesView()
    }
}
