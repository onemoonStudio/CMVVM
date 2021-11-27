//
//  MainTabBarCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import UIKit

enum MainStoryboards: String, InitiatableStoryboardSource {
    case MainTabBarController
}

final class MainTabBarCoordinator: CoordinatorBaseClass {
    func setViewControllers() {
        guard let tabBarController = presentable as? UITabBarController else {
            fatalError()
        }
        
    }
    
    func searchCoordinator() -> SearchCoordinator {
    
    }
}
