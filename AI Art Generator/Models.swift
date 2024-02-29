//
//  Models.swift
//  AI Art Generator
//
//  Created by Kind, Braeden on 2/29/24.
//

import Foundation

enum Constants {
    static let imageSize = "256x256"
    static let n = 2
}

struct GenerationInput: Codable {
    var prompt: String
    var n = Constants.n
    var size = Constants.imageSize
    
    var encodeData: Data? {
        try? JSONEncoder().encode(self)
    }
}
