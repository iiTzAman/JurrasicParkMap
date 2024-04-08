//
//  JurrasicParkData.swift
//  JurrasicParkMap
//
//  Created by Aman Giri on 2024-04-05.
//

import Foundation
import SwiftUI
import MapKit

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
    
    var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}


struct MovieScenes: Codable, Identifiable {
    let id: Int
    let movie: String
    let scene_description: String
}

enum PredatorType: String, Codable, CaseIterable, Identifiable {
    var id: PredatorType {
        return self
    }
    
    case all
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
        case .all:
                .black
        }
    }
    
    var image: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
