//
//  DataLoader.swift
//  HalykProject
//
//  Created by Yeldos Marat on 06.10.2021.
//

import UIKit
 
class DataLoader {
    
    static let shared = DataLoader()
    
    private(set) var pokemonData = [Pokemon]()
    
    private init() {
        load()
    }
    
    func load() {
        
        if let fileLocation = Bundle.main.url(forResource: "pokemon", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Pokemon].self, from: data)
                
                self.pokemonData = dataFromJson
            } catch {
                print(error)
            }
        }
    }
}

