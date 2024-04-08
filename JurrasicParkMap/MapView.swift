//
//  MapView.swift
//  JurrasicParkMap
//
//  Created by Aman Giri on 2024-04-07.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    let dinosaurs = Predators()
    @State var location: MapCameraPosition
    @State var sateliteView = false
    
    var body: some View {
        Map(position: $location){
            ForEach(dinosaurs.allPredatorsList) {
                dinosaurs in
                Annotation(dinosaurs.name, coordinate: dinosaurs.location) {
                    Image(dinosaurs.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .scaleEffect(x:-1)
                        .shadow(color: .white, radius: 5)
                }
            }
        }
        .mapStyle(sateliteView ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing){
            Button{
                sateliteView.toggle()
            } label: {
                Image(systemName: sateliteView ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .background(.thinMaterial)
                    .padding(5)
                    .shadow(radius: 3)
            }
        }
        .toolbarBackground(.automatic)
    }

}

#Preview {
    MapView(location: .camera(MapCamera(centerCoordinate: Predators().allPredatorsList[4].location, distance: 1000, heading: 250, pitch: 80)))
}
