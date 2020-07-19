//
//  Coordinator.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 19.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import Swinject


protocol Coordinator {
    var assemblyContainer: Container { get }

    init(navigationController: UINavigationController, assemblyContainer: Container)
    func start()
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}
