//
//  SearchCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/15.
//

import Foundation

final class SearchCoordinator: BaseCoordinator {
    override func setPresentable() {
        let viewModel = SearchViewModel(coordinator: self)
        let viewController = storyBoardViewController(viewModel: viewModel, SearchViewController.self)
        presentable = viewController
    }
}
