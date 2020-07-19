//
//  AppDelegate.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 16.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import Swinject


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let container = Container()
    
    lazy var appCoordinator: AppCoordinator = {
        let window = UIWindow()
        self.window = window
        return AppCoordinator(window: window, assemblyContainer: container)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupDependencies()
        
        appCoordinator.start()
        return true
    }

}

// MARK: DI
extension AppDelegate {
    func setupDependencies() {
           Assembler(container: container).apply(assemblies: [
               ControllersAssembly(),  // Контейнер с контроллерами
           ])
       }
}
