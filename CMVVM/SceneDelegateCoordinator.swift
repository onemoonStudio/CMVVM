//
//  SceneDelegateCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/23.
//

import Foundation
import UIKit

final class SceneDelegateCoordinator: CoordinatorBaseClass {
    func coordinateMainTabBar(_ uiwindow: UIWindow) {
        let mainTabBarCoordinator = MainTabBarCoordinator()
        guard let tabBarController = storyBoardViewController(MainStoryboards.MainTabBarController, MainTabBarController.self) else {
            fatalError()
        }
        mainTabBarCoordinator.setPresentable(tabBarController)
        coordinate(.makeWindowVisible(uiwindow, root: mainTabBarCoordinator))
    }
}
