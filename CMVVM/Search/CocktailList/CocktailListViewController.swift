//
//  CocktailListViewController.swift
//  CMVVM
//
//  Created by howard on 2021/12/17.
//

import UIKit


final class CocktailListViewController: BaseViewController<CocktailListViewAction, CocktailListModelOutput> {
    
    @IBOutlet weak var navigationBackButton: UIButton!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var cocktailListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        viewBinding()
        viewModelBinding()
        viewAction.loadCocktailList()
    }
    
    private func setAttribute() {
        navigationTitleLabel.text = modelOutput.title
        cocktailListTableView.delegate = self
        cocktailListTableView.dataSource = self
    }
    
    private func viewBinding() {
        navigationBackButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewAction.pop()
            })
            .disposed(by: disposeBag)
    }
    
    private func viewModelBinding() {
        modelOutput.reloadTableViewRelay
            .subscribe(onNext: { [weak self] _ in
                self?.cocktailListTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension CocktailListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelOutput.cocktailList?.drinks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailListTableViewCell", for: indexPath) as? CocktailListTableViewCell else {
            fatalError("cell")
        }
        
        if let cocktailInfo = modelOutput.cocktail(at: indexPath) {
            cell.setUI(thumbURL: cocktailInfo.strDrinkThumb, name: cocktailInfo.strDrink)
        }
        
        cell.setFavorite(modelOutput.isFavoriteCocktail(at: indexPath))
        
        cell.favoriteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewAction.toggleCocktailFavoriteState(at: indexPath)
            })
            .disposed(by: cell.temporaryBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}
