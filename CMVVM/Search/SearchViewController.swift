//
//  SearchViewController.swift
//  CMVVM
//
//  Created by howard on 2021/11/15.
//

import UIKit

final class SearchViewController: BaseViewController<SearchViewAction, SearchModelOutput> {
    @IBOutlet weak var cocktailAlphabetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    private func setTableView() {
        cocktailAlphabetTableView.delegate = self
        cocktailAlphabetTableView.dataSource = self
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelOutput.alphabetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailAlphabetCell", for: indexPath) as? CocktailAlphabetCell else {
            fatalError("cell error")
        }
        cell.setAlphabet(modelOutput.cellAlphabet(at: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewAction.didTapCocktailAlphabet(at: indexPath)
    }
}

final class CocktailAlphabetCell: UITableViewCell {
    @IBOutlet weak var alphabetLabel: UILabel!
    
    func setAlphabet(_ alphabet: String?) {
        alphabetLabel.text = alphabet
    }
}
