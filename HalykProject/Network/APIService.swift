//
//  APIService.swift
//  HalykProject
//
//  Created by Yeldos Marat on 29.09.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SnapKit


final class APIService {
    
    static let shared = APIService()
    
    private lazy var loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)

    private lazy var networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)

    private lazy var provider = MoyaProvider<PokemonsAPI>(
        stubClosure: { api in
            switch api {
            case .pokemons:
                return .immediate
            }
        },
        plugins: [networkLogger])

//    private var pokemonArray = [Pokemon]()
    
    // Fetch Image of Pokemon
    func fetchImage(pokeImg: UIImageView, disposeBag: DisposeBag, pokemon: Pokemon) {
        guard let imgUrl2 = URL(string: (pokemon.imageUrl!)) else { return }
        let image2: UIImageView?
        //rx
        URLSession.shared.rx
            .response(request: URLRequest(url: imgUrl2))
        // subscribe on main thread
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response, data in
                // Update Image
                pokeImg.image = UIImage(data: data)
            }, onError: {_ in
                // Log error
            }, onCompleted: {
                // animate image view alpha
                UIView.animate(withDuration: 0.3) {
                    pokeImg.alpha = 1
                }
            })
            .disposed(by: disposeBag)
    }
    
    // Fetch Pokemon
    func fetchPokemonData() -> Single<[Pokemon]> {
        provider.rx.request(.pokemons)
            .map([Pokemon].self)
    }
}


//        provider.rx.request(., callbackQueue: <#T##DispatchQueue?#>)
        //        provider.request(.pokemons) { result in
        //            switch result {
        //            case .success(let response):
        //                guard let pokemons2 = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [AnyObject] else { return }
        //
        //                for (key, result) in pokemons2.enumerated() {
        //                    if let dict = result as? [String:AnyObject] {
        //                        let pokemon = Pokemon(id: key, dictionary: dict)
        //                        self.pokemonArray.append(pokemon)
        //                    }
        //                }
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
