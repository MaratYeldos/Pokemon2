//
//  AppDelegate.swift
//  HalykProject
//
//  Created by Yeldos Marat on 26.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var fisrtCoordinator : FirstCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup window
//        let viewModel = PokemonViewModel(service: .shared)
//        let controller = PokemonViewController(viewModel: viewModel)
//
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = UINavigationController(rootViewController: controller)
//        window.makeKeyAndVisible()
//        self.window = window
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        
        fisrtCoordinator = FirstCoordinator(navigationController: window?.rootViewController as! UINavigationController)
        
        fisrtCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

