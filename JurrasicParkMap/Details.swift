//
//  Details.swift
//  JurrasicParkMap
//
//  Created by Aman Giri on 2024-04-07.
//

import SwiftUI
import MapKit

struct Details: View {
    
    @Environment(\.openURL) var openURL
    
    var dinosaur: JurrasicParkData
    
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                ZStack(alignment:.bottomTrailing){
                    Image(dinosaur.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    Image(dinosaur.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x:-1)
                        .offset(x:-5,y:20)
                        .shadow(color:.black, radius: 5)
                }
                VStack(alignment:.leading){
                    Text(dinosaur.name)
                        .font(.largeTitle)
                        .bold()
                    
                    NavigationLink{
                        MapView(location: .camera(MapCamera(centerCoordinate: dinosaur.location, distance: 1500, heading: 250, pitch: 80)))
                    } label: {
                        Map(position: $position){
                            Annotation(dinosaur.name, coordinate: dinosaur.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .imageScale(.large)
                                    .font(.largeTitle)
                                    .symbolEffect(.pulse)
                            }
                        }
                        .frame(height: 150)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .topLeading){
                            Text("Current Location")
                                .padding(6)
                                .background(.black.opacity(0.5))
                        }
                    }
                    
                    
                    Text("Appears in")
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        .fontWeight(.bold)
                        .font(.title)
                    ForEach(dinosaur.movies, id: \.self){
                        movie in
                        Text("- " + movie)
                    }
                    
                    Text("Movie Moments")
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        .fontWeight(.bold)
                        .font(.title)

                    ForEach(dinosaur.movie_scenes){
                        movie in
                        Text(movie.movie)
                            .font(.title2)
                        Text(movie.scene_description)
                            .padding(.bottom, 20)
                            .fontWeight(.light)
                    }
                    HStack{
                        Spacer()
                        Button{
                            openURL(URL(string:dinosaur.link)!)
                        }label: {
                            Text("Read More")
                                .font(.title3)
                                .padding(10)
                        }
                        .background(dinosaur.type.backgroundColor)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        Spacer()
                    }
                    
                }
                .padding()
                .frame(width:geo.size.width,alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack{
        Details(dinosaur: Predators().allPredatorsList[10], position: .camera(MapCamera(centerCoordinate: Predators().predator[5].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
