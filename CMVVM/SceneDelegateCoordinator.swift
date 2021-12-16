//
//  SceneDelegateCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/23.
//

import UIKit

final class SceneDelegateCoordinator: BaseCoordinator {
    func coordinateMainTabBar(_ uiwindow: UIWindow) {
        let mainTabBarCoordinator = MainTabBarCoordinator(parent: self)
        coordinate(.makeWindowVisible(uiwindow, root: mainTabBarCoordinator))
    }
}
