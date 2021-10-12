//
//  SecondCoordinator.swift
//  HalykProject
//
//  Created by Yeldos Marat on 06.10.2021.
//

import UIKit

class SecondCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let secondViewController: DetailViewController = DetailViewController(viewModel: DetailViewModel())
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}
