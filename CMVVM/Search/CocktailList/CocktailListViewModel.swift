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
    func toggleCocktailFavoriteState(at indexPath: IndexPath)
    func pop()
}

protocol CocktailListModelOutput {
    var title: String? { get }
    var cocktailList: CocktailInfoList? { get }
    var reloadTableViewRelay: PublishRelay<Void> { get }
    func cocktail(at indexPath: IndexPath) -> CocktailInfoEntity?
    func isFavoriteCocktail(at indexPath: IndexPath) -> Bool
}

final class CocktailListViewModel: BaseViewModel<CocktailListCoordinatorAction>, CocktailListViewAction, CocktailListModelOutput {
    var titleAlphabet: String?
    
    override func baseBinding() {
        FavoriteCocktailStorage.shared
            .favoriteCocktailIdListRelay
            .skip(1)
            .map { _ in Void() }
            .bind(to: reloadTableViewRelay)
            .disposed(by: disposeBag)
    }
    
    // MARK: - view action
    func loadCocktailList() {
        guard let firstLetter = titleAlphabet else {
            return
        }
        cocktailProvider
            .cocktailList(firstLetter)
            .subscribe(onSuccess: { [weak self] list in
                self?.cocktailList = list
                self?.reloadTableViewRelay.accept(Void())
            })
            .disposed(by: disposeBag)
    }
    
    func toggleCocktailFavoriteState(at indexPath: IndexPath) {
        guard let targetCocktail = cocktail(at: indexPath) else {
            return
        }
        FavoriteCocktailStorage.shared.toggleFavoriteCocktail(targetCocktail.idDrink)
        reloadTableViewRelay.accept(Void())
    }
    
    func pop() {
        coordinatorAction?.pop()
    }
    // MARK: - model output
    var title: String? {
        return titleAlphabet
    }
    
    var cocktailList: CocktailInfoList?
    let reloadTableViewRelay = PublishRelay<Void>()
    
    private let cocktailProvider = CocktailProvider()
    
    func cocktail(at indexPath: IndexPath) -> CocktailInfoEntity? {
        guard let drinks = cocktailList?.drinks, drinks.count > indexPath.row else {
            return nil
        }
        return drinks[indexPath.row]
    }
    
    func isFavoriteCocktail(at indexPath: IndexPath) -> Bool {
        guard let targetCocktail = cocktail(at: indexPath) else {
            return false
        }
        return FavoriteCocktailStorage.shared.isContainFavoriteCocktail(id: targetCocktail.idDrink)
    }
}
