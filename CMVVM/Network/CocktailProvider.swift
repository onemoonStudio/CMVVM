//
//  CocktailProvider.swift
//  CMVVM
//
//  Created by howard on 2021/12/09.
//

import Moya
import RxMoya
import RxSwift

final class CocktailProvider: MoyaProvider<CocktailTarget> {
    func cocktailList(_ firstLetter: String) -> Single<CocktailInfoList> {
        rx.request(.list(withFirstLetter: firstLetter))
            .map(CocktailInfoList.self)
    }
    
    func cocktailDetail(_ id: String) -> Single<CocktailDetailResponse> {
        rx.request(.detail(id: id))
            .map(CocktailDetailResponse.self)
    }
}

