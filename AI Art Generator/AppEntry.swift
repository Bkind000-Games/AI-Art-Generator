//
//  AI_Art_GeneratorApp.swift
//  AI Art Generator
//
//  Created by Kind, Braeden on 2/27/24.
//

import SwiftUI

@main
struct AppEntry: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        let sample = GenerationInput(prompt: "Man in a rowboat in the ocean in a storm similar to work by Van Gogh")
                        if let data = sample.encodeData {
                            try await APIService().fetchImages(with: data)
                        }
                    }
                }
        }
    }
}
