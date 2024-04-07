//
//  JurrasicParkData.swift
//  JurrasicParkMap
//
//  Created by Aman Giri on 2024-04-05.
//

import Foundation
import SwiftUI

struct JurrasicParkData: Codable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movie_scenes: [MovieScenes]
    let link: String
    
    var image: String {
       return name.lowercased().replacingOccurrences(of: " ", with: "")
    }
}

struct MovieScenes: Codable, Identifiable {
    let id: Int
    let movie: String
    let scene_description: String
}

enum PredatorType: String, Codable {
    case land
    case air
    case sea
    
    var backgroundColor: Color {
        switch self {
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        }
    }
}
