//
//  AppCoordinator.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 19.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import Swinject

enum AppCoordinatorWays {
    case main
    case news
}

protocol AppCoordinatorDelegate {
    func authFinish ()
}

class AppCoordinator: NavigationCoordinator {
    
    weak var window: UIWindow!
    
    var assemblyContainer: Container
    var navigationController: UINavigationController
    var childCoordinators: [AppCoordinatorWays: Coordinator] = [:]
    
    required init(window: UIWindow?, assemblyContainer: Container) {
        self.navigationController = UINavigationController()
        self.assemblyContainer = assemblyContainer
        self.window = window
    }
    
    func start() {
        let authController = assemblyContainer.resolve(AuthorizationViewController.self)!
        authController.coordinatorDelegate = self
        navigationController.viewControllers = [authController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

extension AppCoordinator: AppCoordinatorDelegate {
    
    func authFinish() {
        if let tabBarController = assemblyContainer.resolve(UITabBarController.self) {
            navigationController.pushViewController(tabBarController, animated: true)
        }
    }
    
}
