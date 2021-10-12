//
//  PokemonTableViewCell.swift
//  HalykProject
//
//  Created by Yeldos Marat on 26.09.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SnapKit

class PokemonTableViewCell: UITableViewCell {

//    static let identifier = "cell"

    private var imgView = UIImageView()
    
    lazy var pokemonTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(pokemonTitle)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(10.0)
            make.bottom.equalTo(self.contentView).offset(-10.0)
            make.leading.equalTo(self.contentView).offset(10.0)
            make.width.equalTo(150.0)
        }
        
        pokemonTitle.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(50.0)
            make.leading.equalTo(self.imgView.snp.trailing).offset(40.0)
            make.height.equalTo(25.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Func
    func configureWithPokemon(pokemon: Pokemon) {
        self.pokemonTitle.text = pokemon.name
        guard
            let imageURLString = pokemon.imageUrl,
            let imageURL = URL(string: imageURLString) else { return }
        
        imgView.alpha = 0
        
        // RX
//        Service.shared.fetchImage(pokeImg: imgView, disposeBag: disposeBag, pokemon: pokemon)
        URLSession.shared.rx
            .response(request: URLRequest(url: imageURL))
            // subscribe on main thread
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response, data in
                // Update Image
                self?.imgView.image = UIImage(data: data)
            }, onError: {_ in
                // Log error
            }, onCompleted: {
                // animate image view alpha
                UIView.animate(withDuration: 0.3) {
                    self.imgView.alpha = 1
                }
            })
            .disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = .init()
    }
}

