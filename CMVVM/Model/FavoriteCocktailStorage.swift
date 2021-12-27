//
//  FavoriteCocktailStorage.swift
//  CMVVM
//
//  Created by howard on 2021/12/27.
//

import Foundation
import RxRelay

final class FavoriteCocktailStorage {
    
    static let shared = FavoriteCocktailStorage()
    
    let favoriteCocktailIdListRelay = BehaviorRelay<[String]>(value: [])
    
    private let favoriteCocktailIdSetKey = "favoriteCocktailIdSetKey"
    
    private init() {
        favoriteCocktailIdListRelay.accept(favoriteCocktailIdList())
    }
    
    func isContainFavoriteCocktail(id: String) -> Bool {
        return favoriteCocktailIdListRelay.value.contains(id)
    }
    
    func toggleFavoriteCocktail(_ id: String) {
        if isContainFavoriteCocktail(id: id) {
            removeFavoriteCocktail(id)
        } else {
            addFavoriteCocktail(id)
        }
    }
    
    private func favoriteCocktailIdList() -> [String] {
        if let idList =  UserDefaults.standard.value(forKey: favoriteCocktailIdSetKey) as? [String] {
            return idList
        } else {
            return []
        }
    }
    
    private func saveFavoriteCocktailListAndUpdate(_ list: [String]) {
        UserDefaults.standard.set(list, forKey: favoriteCocktailIdSetKey)
        favoriteCocktailIdListRelay.accept(list)
    }
    
    private func addFavoriteCocktail(_ id: String) {
        var originList = favoriteCocktailIdListRelay.value
        guard !originList.contains(id) else { return }
        originList.append(id)
        saveFavoriteCocktailListAndUpdate(originList)
    }
    
    private func removeFavoriteCocktail(_ id: String) {
        var originList = favoriteCocktailIdListRelay.value
        guard let removeIndex = originList.firstIndex(of: id) else { return }
        originList.remove(at: removeIndex)
        saveFavoriteCocktailListAndUpdate(originList)
        
    }
}
