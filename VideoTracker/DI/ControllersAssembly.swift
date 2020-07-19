//
//  ControllersAssembly.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 19.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import Swinject


struct ControllersAssembly: Assembly {
    
    func assemble(container: Container) {
        // Конроллер авторизации
        container.register(AuthorizationViewController.self) { _ in
            return AuthorizationViewController()
        }
        
        // TabBar контроллер
        container.register(UITabBarController.self) { _ in
            let newsViewModel = NewsListViewModel(newsService: NewsMockService())
            let newsListController = NewsListViewController(viewModel: newsViewModel)
            newsListController.tabBarItem = UITabBarItem.init(title: "Лента", image: .newsLine, tag: 0)
            
            let categoriesViewModel = CategoriesViewModel()
            let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
            categoriesViewController.tabBarItem = UITabBarItem.init(title: "Категории", image: .categories, tag: 1)
            
            let chatViewController = ChatViewController()
            chatViewController.tabBarItem = UITabBarItem.init(title: "Чат", image: .chat, tag: 2)
            
            let settingsViewController = SettingsViewController()
            settingsViewController.tabBarItem = UITabBarItem.init(title: "Настройки", image: .settings, tag: 3)
            
            let tabBarController = UITabBarController()
            tabBarController.tabBar.isTranslucent = false
            tabBarController.tabBar.tintColor = UIColor.black
            tabBarController.tabBar.unselectedItemTintColor = UIColor.unselectedColor
            
            tabBarController.setViewControllers([UINavigationController.init(rootViewController: newsListController),
                                                 UINavigationController.init(rootViewController: categoriesViewController),
                                                 UINavigationController.init(rootViewController: chatViewController),
                                                 UINavigationController.init(rootViewController: settingsViewController)],
                                                animated: true)
            
            
            return tabBarController
        }
    }
}
