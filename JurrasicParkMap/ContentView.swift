//
//  ContentView.swift
//  JurrasicParkMap
//
//  Created by Aman Giri on 2024-04-05.
//

import SwiftUI

struct ContentView: View {
    
    let jurassicPredators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    
    var filteredDinosaurList: [JurrasicParkData] {
        jurassicPredators.sortData(by: alphabetical)
        return jurassicPredators.filterData(for: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinosaurList){ predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack(){
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .shadow(color:.white,radius: 1)
                        VStack(alignment: .leading){
                            Text(predator.name)
                                .fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.vertical, 5)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10)
                                .frame(width: 80, height: 30)
                                .background(predator.type.backgroundColor)
                                .clipShape(.capsule)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationTitle("Dinosaur List")
            .searchable(text: $searchText)
            .animation(.easeInOut, value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .foregroundColor(.white)
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
