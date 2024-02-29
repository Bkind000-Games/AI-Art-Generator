//
//  APIService.swift
//  AI Art Generator
//
//  Created by Kind, Braeden on 2/29/24.
//

import Foundation

class APIService {
    let baseURL = "https://api.openai.com/v1/images/"
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func fetchImages(with data: Data) async throws {
        guard let apiKey else { fatalError("Failed to get APIKey.")}
        guard let url = URL(string: baseURL + "generations") else {
            fatalError("ERROR: Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        let (data,response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse) != nil else {
            fatalError("ERROR: Data Request has failed.")
        }
        print(String(decoding: data, as: UTF8.self))
    }
}
