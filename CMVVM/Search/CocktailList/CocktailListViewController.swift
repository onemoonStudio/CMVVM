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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        viewBinding()
    }
    
    private func setTitleLabel() {
        navigationTitleLabel.text = modelOutput.title
    }
    
    private func viewBinding() {
        navigationBackButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewAction.pop()
            })
            .disposed(by: disposeBag)
    }
}
