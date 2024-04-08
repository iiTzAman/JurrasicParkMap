//
//  Predators.swift
//  JurrasicParkMap
//
//  Created by Aman Giri on 2024-04-05.
//

import Foundation
import MapKit


class Predators {
    var allPredatorsList: [JurrasicParkData] = []
    var predator: [JurrasicParkData] = []
    
    init(){
        decodeData()
    }
    
    func decodeData(){
        if let url = Bundle.main.url(forResource: "AppData", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allPredatorsList = try decoder.decode([JurrasicParkData].self, from: data)
                predator = allPredatorsList
            }catch{
                print("Error getting data")
            }
        }
    }
    
    func filterData(for searchText: String) -> [JurrasicParkData] {
        if searchText.isEmpty {
            return predator
        }else{
           return predator.filter { dinosaur in
                dinosaur.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func sortData (by alphabetical: Bool){
        predator.sort { dinosaur1, dinosaur2 in
            if alphabetical {
                dinosaur1.name < dinosaur2.name
            }else {
                dinosaur1.id < dinosaur2.id
            }
        }
    }
    
    func filterByType(type: PredatorType){
        if type == .all {
            predator = allPredatorsList
        } else {
            predator = allPredatorsList.filter { dinosaur in
                type == dinosaur.type
            }
        }
    }
}
