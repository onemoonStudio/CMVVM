//
//  CocktailDetailViewModel.swift
//  CMVVM
//
//  Created by howard on 2021/12/27.
//

import Foundation

protocol CocktailDetailViewAction {
    
}

protocol CocktailDetailModelOutput {
    
}

final class CocktailDetailViewModel: BaseViewModel<CocktailDetailCoordinatorAction>, CocktailDetailViewAction, CocktailDetailModelOutput {
    
}
