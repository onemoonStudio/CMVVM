//
//  StoryboardableCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import Foundation
import UIKit

enum MainStoryboards: String, InitiatableStoryboardSource {
    case MainTabBarController
    
    var storyBoardName: String {
        return self.rawValue
    }
}

protocol InitiatableStoryboardSource {
    var storyBoardName: String { get }
    var storyBoard: UIStoryboard { get }
    func initialViewController<ViewControllerType: UIViewController>(_ type: ViewControllerType.Type) -> ViewControllerType?
    func targetViewController<ViewControllerType: UIViewController>(_ identifier: String, _ type: ViewControllerType.Type) -> ViewControllerType?
}

extension InitiatableStoryboardSource {
    var storyBoard: UIStoryboard {
        return UIStoryboard(name: storyBoardName, bundle: nil)
    }
    
    func initialViewController<ViewControllerType: UIViewController>(_ type: ViewControllerType.Type) -> ViewControllerType? {
        guard let initialViewController = storyBoard.instantiateInitialViewController() as? ViewControllerType else {
            return nil
        }
        return initialViewController
    }
    
    func targetViewController<ViewControllerType: UIViewController>(_ identifier: String, _ type: ViewControllerType.Type) -> ViewControllerType? {
        guard let targetViewController = storyBoard.instantiateViewController(withIdentifier: identifier) as? ViewControllerType else {
            return nil
        }
        return targetViewController
    }
}

protocol StoryBoardableCoordinator {
    func storyBoardViewController<ViewControllerType: UIViewController>(_ source: InitiatableStoryboardSource, _ type: ViewControllerType.Type, _ identifier: String?) -> ViewControllerType?
}

extension StoryBoardableCoordinator {
    func storyBoardViewController<ViewControllerType: UIViewController>(_ source: InitiatableStoryboardSource, _ type: ViewControllerType.Type, _ identifier: String? = nil) -> ViewControllerType? {
        if let identifier = identifier {
            return source.targetViewController(identifier, type)
        } else {
            return source.initialViewController(type)
        }
    }
}
