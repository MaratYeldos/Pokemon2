//
//  Pokemon.swift
//  HalykProject
//
//  Created by Yeldos Marat on 26.09.2021.
//

import UIKit

struct Pokemon: Codable {
    let attack, defense: Int?
    let pokemonDescription: String?
//    let evolutionChain: [EvolutionChain]?
    let height, id: Int?
    let imageUrl: String?
    let name, type: String?
    let weight, pokemonDefense: Int?

    enum CodingKeys: String, CodingKey {
        case attack, defense
        case pokemonDescription
        case height, id
        case imageUrl
        case name, type, weight
        case pokemonDefense
// evolutionChain,
    }
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let id, name: String?
}



//struct Pokemon: Codable, Hashable, Equatable {
    
//    var name: String?
//    var imageUrl: String?
//    var id: Int?
//    var weight: Int?
//    var height: Int?
//    var defense: Int?
//    var attack: Int?
//    var description: String?
//    var type: String?
    
    
//    init(id: Int?, dictionary: [String: AnyObject]) {
//
//        self.id = id
//
//        if let name = dictionary["name"] as? String {
//            self.name = name
//        }
//
//        if let imageUrl = dictionary["imageUrl"] as? String {
//            self.imageUrl = imageUrl
//        }
//
//        if let weight = dictionary["weight"] as? Int {
//            self.weight = weight
//        }
//
//        if let height = dictionary["height"] as? Int {
//            self.height = height
//        }
//
//        if let defense = dictionary["defense"] as? Int {
//            self.defense = defense
//        }
//
//        if let attack = dictionary["attack"] as? Int {
//            self.attack = attack
//        }
//
//        if let description = dictionary["description"] as? String {
//            self.description = description
//        }
//
//        if let type = dictionary["type"] as? String {
//            self.type = type.capitalized
//        }
//    }
//}
