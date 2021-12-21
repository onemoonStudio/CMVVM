//
//  SearchCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/15.
//

import Foundation

protocol SearchCoordinatorAction {
    func showCocktailList(for alphabet: String)
}

final class SearchCoordinator: BaseCoordinator, SearchCoordinatorAction {
    func showCocktailList(for alphabet: String) {
        coordinate(.push(cocktailListCoordinator(alphabet)))
    }
    
    override func setPresentable() {
        let viewModel = SearchViewModel(coordinator: self)
        let viewController = storyBoardViewController(viewModel: viewModel, SearchViewController.self)
        presentable = viewController
    }
    
    private func cocktailListCoordinator(_ titleAlphabet: String) -> CocktailListCoordinator {
        let cocktailListCoordinator = CocktailListCoordinator(parent: self, title: titleAlphabet)
        return cocktailListCoordinator
    }
}
