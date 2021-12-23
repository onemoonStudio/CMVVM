//
//  CocktailListTableViewCell.swift
//  CMVVM
//
//  Created by howard on 2021/12/23.
//

import UIKit
import Kingfisher

final class CocktailListTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tnumbDownloadTask?.cancel()
    }
}
