//
//  MainTabBarCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import UIKit

final class MainTabBarCoordinator: CoordinatorBase {
    var viewController: UIViewController? {
        return storyBoardViewController(MainStoryboards.MainTabBarController, MainTabBarController.self)
    }
}
