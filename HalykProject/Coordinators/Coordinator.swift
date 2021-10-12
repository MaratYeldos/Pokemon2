//
//  Coordinator.swift
//  HalykProject
//
//  Created by Yeldos Marat on 30.09.2021.
//

import UIKit

public protocol Coordinator {

    var childCoordinators: [Coordinator] { get set }

    init(navigationController:UINavigationController)

    func start()

}
