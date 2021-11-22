//
//  SearchCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/15.
//

import UIKit

private enum SearchStoryBoards: String, InitiatableStoryboardSource {
    case SearchViewController
}

final class SearchCoordinator: CoordinatorBase {
    var viewController: UIViewController? {
        storyBoardViewController(SearchStoryBoards.SearchViewController, SearchViewController.self)
    }
}
