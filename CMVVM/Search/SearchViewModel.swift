//
//  SearchViewModel.swift
//  CMVVM
//
//  Created by howard on 2021/11/15.
//

import Foundation
import RxSwift

protocol SearchViewAction {
    func didTapCocktailAlphabet(at indexPath: IndexPath)
}

protocol SearchModelOutput {
    var alphabetList: [String] { get }
    func cellAlphabet(at indexPath: IndexPath) -> String?
}

final class SearchViewModel: BaseViewModel, SearchViewAction, SearchModelOutput {
    func didTapCocktailAlphabet(at indexPath: IndexPath) {
        // coordinate
        
    }
    
    let alphabetList: [String] = [Int](65...90).compactMap { UnicodeScalar($0) }.map { String(Character($0)) }
    
    func cellAlphabet(at indexPath: IndexPath) -> String? {
        guard alphabetList.count > indexPath.row else { return nil }
        return alphabetList[indexPath.row]
    }
}
