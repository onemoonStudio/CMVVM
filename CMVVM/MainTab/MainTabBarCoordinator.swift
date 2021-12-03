//
//  MainTabBarCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import UIKit

// 문제가 뭘까? -> 결국 coordiantor 를 조립하기 위해서는 coordinator, viewcontroller, viewmodel 이 세가지를 만들어야 함
// 생각해보면 외부에서 viewmodel를 받는것이 어색함 -> 내부에서 viewmodel을 만들어야 한다.

final class MainTabBarCoordinator: BaseCoordinator {
    static func Generate(_ parent: BaseCoordinator?) -> MainTabBarCoordinator {
        let coordinator = MainTabBarCoordinator(parent: parent)
        // generate ? 살짝 어색한것 같기도 함
        coordinator.start()
        return coordinator
    }
    
    func setPresentable() {
        let viewModel = MainTabBarViewModel()
        let tabbarController = MainTabBarController.initialViewController(viewModel: viewModel, MainTabBarController.self)
        presentable = tabbarController
    }
    
    func start() {
        let viewModel = MainTabBarViewModel()
        let tabbarController = MainTabBarController.initialViewController(viewModel: viewModel, MainTabBarController.self)
        presentable = tabbarController
        setViewControllers()
    }
    
    private func setViewControllers() {
        let presentable = presentable as? MainTabBarController
        presentable?.viewControllers = []
    }
}
