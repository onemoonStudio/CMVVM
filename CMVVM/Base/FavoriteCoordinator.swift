//
//  FavoriteCoordinator.swift
//  CMVVM
//
//  Created by HyeonTae Kim on 2021/11/28.
//

import Foundation

final class FavoriteCoordinator: BaseCoordinator {
    override func setPresentable() {
        let viewModel = FavoriteViewModel(coordinator: self)
        let viewController = storyBoardViewController(viewModel: viewModel, FavoriteViewController.self)
        presentable = viewController
    }
}
