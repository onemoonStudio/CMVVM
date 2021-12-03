//
//  MainTabBarCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import UIKit

final class MainTabBarCoordinator: BaseCoordinator {
    override func setPresentable() {
        let viewModel = MainTabBarViewModel(coordinator: self)
        let tabbarController = MainTabBarController.initialViewController(viewModel: viewModel, MainTabBarController.self)
        presentable = tabbarController
        setViewControllers()
    }
    
    private func setViewControllers() {
        let tabBarController = presentable as? MainTabBarController
        tabBarController?.viewControllers = [searchNavigationController(), favoriteNavigationController()]
    }
    
    private func searchNavigationController() -> UINavigationController {
        let searchCoordinator = SearchCoordinator(parent: self)
        guard let searchViewController = searchCoordinator.presentable as? SearchViewController else {
            fatalError()
        }
        addChild(searchCoordinator)
        let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        return navigationController
    }
    
    private func favoriteNavigationController() -> UINavigationController {
        let favoriteCoordinator = FavoriteCoordinator(parent: self)
        guard let favoriteViewController = favoriteCoordinator.presentable as? FavoriteViewController else {
            fatalError()
        }
        addChild(favoriteCoordinator)
        let navigationController = UINavigationController(rootViewController: favoriteViewController)
        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.circle"), selectedImage: UIImage(systemName: "heart.circle.fill"))
        return navigationController
    }
}
