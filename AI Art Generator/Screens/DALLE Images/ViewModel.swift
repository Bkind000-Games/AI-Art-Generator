//
//  ViewModel.swift
//  AI Art Generator
//
//  Created by Kind, Braeden on 3/4/24.
//

import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var prompt = ""
    @Published var urls: [URL] = []
    @Published var dalleImages: [DalleImage] = []
    @Published var fetching = false
    
    let apiService = APIService()
    
    func clearProperties() {
        urls = []
        dalleImages.removeAll()
        for _ in 1...Constants.n {
            dalleImages.append(DalleImage())
        }
    }
    
    init() {
        clearProperties()
    }
    
    func fetchImages() {
        clearProperties()
        withAnimation {
            fetching.toggle()
        }
        let genInput = GenerationInput(prompt: prompt)
        Task {
            if let data = genInput.encodeData {
                do {
                    let response = try await apiService.fetchImages(with: data)
                    for data in response.data {
                        urls.append(data.url)
                    }
                    withAnimation {
                        fetching.toggle()
                    }
                    for (index,url) in urls.enumerated() {
                        dalleImages[index].uiImage = await apiService.loadImage(at: url)
                    }
                } catch {
                    print(error.localizedDescription)
                    fetching.toggle()
                }
            }
        }
    }
}
