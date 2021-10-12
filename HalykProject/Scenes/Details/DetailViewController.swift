//
//  DetailViewController.swift
//  HalykProject
//
//  Created by Yeldos Marat on 26.09.2021.
//

import Moya
import RxSwift
import RxCocoa
import SnapKit
import UIKit


class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var pokemon: Pokemon?
    
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var disposeBag = DisposeBag()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let img: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let weight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let height: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let defense: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let attack: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let descrText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        label.text = "Description"
        label.textColor = .black
        return label
    }()
    
    private let descrip: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let type: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return UIScrollView()
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        guard let pokemon = pokemon else { return }
        APIService.shared.fetchImage(pokeImg: img, disposeBag: disposeBag, pokemon: pokemon)
        
        name.text = pokemon.name
        weight.text = "weight: \(pokemon.weight ?? 0)kg"
        height.text = "height: \(pokemon.height ?? 0)m"
        attack.text = "attack: \(pokemon.attack ?? 0)"
        defense.text = "defense: \(pokemon.defense ?? 0)"
        descrip.text = "\(pokemon.pokemonDescription ?? "")"
        type.text = "Type: \(pokemon.type ?? "")"
        
        setupConstraints()
    }
    
    //MARK: - Setup Contstaints
    
    func setupConstraints() {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth/2, height: 1000)
        
        view.addSubview(scrollView)
        scrollView.addSubview(img)
        scrollView.addSubview(name)
        scrollView.addSubview(weight)
        scrollView.addSubview(height)
        scrollView.addSubview(defense)
        scrollView.addSubview(attack)
        scrollView.addSubview(descrip)
        scrollView.addSubview(type)
        scrollView.addSubview(descrText)
        
        scrollView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
        
        img.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(250)
        }
        
        name.snp.makeConstraints { make in
            make.bottom.equalTo(self.img).offset(30)
            make.centerX.equalTo(self.img)
            make.width.equalTo(150)
        }
        
        weight.snp.makeConstraints { make in
            make.bottom.equalTo(self.name).offset(50)
            make.leading.equalToSuperview().offset(15)
        }

        height.snp.makeConstraints { make in
            make.bottom.equalTo(self.weight).offset(30)
            make.leading.equalToSuperview().offset(15)
        }

        defense.snp.makeConstraints { make in
            make.bottom.equalTo(self.height).offset(30)
            make.leading.equalToSuperview().offset(15)
        }

        attack.snp.makeConstraints { make in
            make.bottom.equalTo(self.defense).offset(30)
            make.leading.equalToSuperview().offset(15)
        }
        
        type.snp.makeConstraints { make in
            make.bottom.equalTo(self.attack).offset(30)
            make.leading.equalToSuperview().offset(15)
        }
        
        descrText.snp.makeConstraints { make in
            make.bottom.equalTo(self.type).offset(50)
            make.centerX.equalTo(self.img)
            make.height.equalTo(70)
            make.width.equalTo(150)
        }
        
        descrip.snp.makeConstraints { make in
            make.top.equalTo(self.descrText).offset(70)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(400)
        }
    }
}
