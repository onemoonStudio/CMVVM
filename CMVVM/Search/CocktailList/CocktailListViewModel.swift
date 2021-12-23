//
//  CocktailListViewModel.swift
//  CMVVM
//
//  Created by howard on 2021/12/17.
//

import Foundation
import RxRelay

protocol CocktailListViewAction {
    func loadCocktailList()
    func pop()
}

protocol CocktailListModelOutput {
    var title: String? { get }
    var cocktailListRelay: BehaviorRelay<CocktailInfoList?> { get }
    func cocktail(at indexPath: IndexPath) -> CocktailInfoEntity?
}

final class CocktailListViewModel: BaseViewModel<CocktailListCoordinatorAction>, CocktailListViewAction, CocktailListModelOutput {
    var titleAlphabet: String?
    
    // MARK: - view action
    func loadCocktailList() {
        guard let firstLetter = titleAlphabet else {
            return
        }
        cocktailProvider
            .cocktailList(firstLetter)
            .subscribe(onSuccess: { [weak self] list in
                self?.cocktailListRelay.accept(list)
            })
            .disposed(by: disposeBag)
    }
    
    func pop() {
        coordinatorAction?.pop()
    }
    // MARK: - model output
    var title: String? {
        return titleAlphabet
    }
    
    let cocktailListRelay = BehaviorRelay<CocktailInfoList?>(value: nil)
    
    private let cocktailProvider = CocktailProvider()
    
    func cocktail(at indexPath: IndexPath) -> CocktailInfoEntity? {
        guard let drinks = cocktailListRelay.value?.drinks, drinks.count > indexPath.row else {
            return nil
        }
        return drinks[indexPath.row]
    }
}
