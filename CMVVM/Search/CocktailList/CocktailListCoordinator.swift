//
//  CocktailListCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/12/17.
//

import Foundation

protocol CocktailListCoordinatorAction {
    func pop()
}

final class CocktailListCoordinator: BaseCoordinator, CocktailListCoordinatorAction {
    
    var titleAlphabet: String
    
    init(parent: BaseCoordinatorProtocol?, title: String) {
        self.titleAlphabet = title
        super.init(parent: parent)
    }
    
    override func setPresentable() {
        let viewModel = CocktailListViewModel(coordinator: self)
        viewModel.titleAlphabet = titleAlphabet
        
        let viewController = storyBoardViewController(viewModel: viewModel, CocktailListViewController.self)
        presentable = viewController
    }
    
    func pop() {
        coordinate(.pop)
    }
}
