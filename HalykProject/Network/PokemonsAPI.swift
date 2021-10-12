//
//  PokemonsAPI.swift
//  HalykProject
//
//  Created by Yeldos Marat on 26.09.2021.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

enum PokemonsAPI {
    
    case pokemons
}

extension PokemonsAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://pokedex-bb36f.firebaseio.com")!
    }
    
    var path: String {
        switch self {
        case .pokemons:
            return "/pokemon.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .pokemons:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain // TODO
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        guard let path = Bundle.main.path(forResource: "pokemon", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                  return Data()
              }
        return data
    }
}
