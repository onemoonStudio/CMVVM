//
//  CocktailListViewModel.swift
//  CMVVM
//
//  Created by howard on 2021/12/17.
//

import Foundation

protocol CocktailListViewAction {
    func pop()
}

protocol CocktailListModelOutput {
    var title: String? { get }
}

final class CocktailListViewModel: BaseViewModel<CocktailListCoordinatorAction>, CocktailListViewAction, CocktailListModelOutput {
    var titleAlphabet: String?
    var title: String? {
        return titleAlphabet
    }
    
    func pop() {
        coordinatorAction?.pop()
    }
}
