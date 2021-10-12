//
//  PokemonViewModel.swift
//  HalykProject
//
//  Created by Yeldos Marat on 28.09.2021.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

protocol ViewModelType {
    
    associatedtype Input
    
    associatedtype Output

    func transform(input: Input) -> Output
}

// MVVM + RX + Clean Architecture + Coordinator

final class PokemonViewModel: ViewModel, ViewModelType {
    
    struct Input {
        
        let refresh: Observable<Void>
        
//        let indexPok: Observable<Int>
    }
    
    struct Output {
        
        let pokemons: Observable<[Pokemon]>
//        let pokIndx : Observable<Int>
    }
    
    private let service: APIService
    
    private let pokemonsRelay: BehaviorRelay<[Pokemon]?> = .init(value: nil)
    
    init(service: APIService) {
        self.service = service
        print(pokemonsRelay)
    }
    
    func transform(input: Input) -> Output {
        
        input.refresh
            // .debug()
            .flatMapLatest { [unowned self] _ -> Single<[Pokemon]> in
                self.getPokemons()
            }
            // .debug("[pokemons response]: ")
            .subscribe(onNext: { [weak self] pokemons in
                self?.pokemonsRelay.accept(pokemons)
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
        
        return .init(pokemons: pokemonsRelay.asObservable().compactMap({ $0 }))
    }
}

class ViewModel {
    
    var disposeBag: DisposeBag = .init()
}

private extension PokemonViewModel {
    
    func getPokemons() -> Single<[Pokemon]> {
        service.fetchPokemonData()
    }
}


extension PokemonViewModel {
    
//    func makeViewControllerB() -> UIViewController {
//        let viewModel = DetailViewModel(pokemonData: self)
//        return DetailViewController()
//    }
}
