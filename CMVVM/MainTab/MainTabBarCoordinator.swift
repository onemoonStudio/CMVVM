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

final class MainTabBarCoordinator: CoordinatorBase {
    var viewController: UIViewController? {
        let tabBarController = storyBoardViewController(MainStoryboards.MainTabBarController, MainTabBarController.self)
        tabBarController?.viewControllers = childCoordinators.compactMap { $0.viewController }
        return storyBoardViewController(MainStoryboards.MainTabBarController, MainTabBarController.self)
    }
    
    lazy var childCoordinators: [CoordinatorBase] = [SearchCoordinator()]
}
