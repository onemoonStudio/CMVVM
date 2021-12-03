//
//  SceneDelegateCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/23.
//

import Foundation
import UIKit

final class SceneDelegateCoordinator: BaseCoordinator {
    func coordinateMainTabBar(_ uiwindow: UIWindow) {
        let mainTabBarCoordinator = MainTabBarCoordinator(parent: self)
        // presentable 을 만들어야 한다. 근데 여기서??
        coordinate(.makeWindowVisible(uiwindow, root: mainTabBarCoordinator))
    }
}
