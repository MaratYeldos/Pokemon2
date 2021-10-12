//
//  FirstCoordinator.swift
//  HalykProject
//
//  Created by Yeldos Marat on 06.10.2021.
//

import Foundation
import UIKit

class FirstCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController = PokemonViewController(viewModel: .init(service: .shared))
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
    }
    
}


extension FirstCoordinator: PokemonViewControllerDelegate {

    // Navigate to next page
    func navigateToNextPage() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        childCoordinators.append(secondCoordinator)
        secondCoordinator.start()
    }
}
