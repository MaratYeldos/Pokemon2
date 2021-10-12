//
//  ViewController.swift
//  HalykProject
//
//  Created by Yeldos Marat on 26.09.2021.
//

import UIKit
import RxSwift
import Moya
import RxCocoa


public protocol PokemonViewControllerDelegate: class {
    func navigateToNextPage()
}

class PokemonViewController: UIViewController {
    
    // View Model
    private var viewModel: PokemonViewModel
    public weak var delegate: PokemonViewControllerDelegate?
    
    private let cellReuseIdentifier: String = String(describing: PokemonTableViewCell.self)
    
    //MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 140
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: PokemonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Navigation
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Pokedex"
                
        configureTableView()
        bind()
    }
    
    var indx = 0
    
    func bind() {
        let input: PokemonViewModel.Input = .init(refresh: Observable.just(()))
        
        let output: PokemonViewModel.Output = viewModel.transform(input: input)
        
        output.pokemons
            .bind(to: tableView.rx.items(cellIdentifier: cellReuseIdentifier, cellType: PokemonTableViewCell.self)) { (_, item, cell) in
                cell.configureWithPokemon(pokemon: item)
            }
            .disposed(by: disposeBag)
        
        setupCellTapHandling()
    }
}


//MARK: Rx Setup
private extension PokemonViewController {
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
//    func setupCellConfiguration() {
//        pokemonViewModel.getData()
//            .bind(to: tableView
//                    .rx
//                    .items(cellIdentifier: PokemonTableViewCell.identifier,
//                           cellType: PokemonTableViewCell.self)) { row, pokemon, cell in
////                guard let pokemon = pokemon else { return }
//                print(pokemon)
//                cell.configureWithPokemon(pokemon: pokemon)
//            } .disposed(by: disposeBag)
//    }
//
    func setupCellTapHandling() {
        tableView.rx
            .modelSelected(Pokemon.self)
            .subscribe(onNext:  { value in
                let detailVC = DetailViewController(viewModel: DetailViewModel())
                
                self.delegate?.navigateToNextPage()
//                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}


//MARK: TableView

extension PokemonViewController: /*UITableViewDataSource,*/ UITableViewDelegate {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//         return 1
//     }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pokemonArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as! PokemonTableViewCell
//
//        let pokemon = pokemonArray[indexPath.row]
//        print(pokemon)
//        cell.configureWithPokemon(pokemon: pokemon)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150.0
//    }
//
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let detailVC = DetailViewController()
////        detailVC.pokemon = pokemonArray[indexPath.row]
////        navigationController?.pushViewController(detailVC, animated: true)
//        self.delegate?.navigateToNextPage()
//        return tableView.deselectRow(at: indexPath, animated: true)
//    }
}


