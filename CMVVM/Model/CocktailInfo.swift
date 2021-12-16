//
//  CocktailInfo.swift
//  CMVVM
//
//  Created by howard on 2021/12/08.
//

import Foundation

struct CocktailInfoList: Decodable {
    let drinks: [CocktailInfoEntity]
}

struct CocktailInfoEntity: Decodable {
    let strDrink: String
    let strDrinkThumb : String
    let idDrink: String
}
