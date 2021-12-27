//
//  CocktailListTableViewCell.swift
//  CMVVM
//
//  Created by howard on 2021/12/23.
//

import UIKit
import RxSwift
import Kingfisher

final class CocktailListTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var temporaryBag: DisposeBag = DisposeBag()
    var tnumbDownloadTask: DownloadTask?
    
    func setUI(thumbURL: String?, name: String?) {
        if let thumbURL = thumbURL {
            tnumbDownloadTask = thumbnailImageView.kf.setImage(with: URL(string: thumbURL),
                                                               placeholder: nil,
                                                               options: nil,
                                                               completionHandler: nil)
        }
        cocktailNameLabel.text = name
    }
    
    func setFavorite(_ isFavorite: Bool) {
        favoriteButton.isSelected = isFavorite
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tnumbDownloadTask?.cancel()
        temporaryBag = DisposeBag()
    }
}
