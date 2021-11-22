//
//  StoryboardableCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import Foundation
import UIKit

protocol InitiatableStoryboardSource {
    // enum의 rawValue 자체 또한 protocol로 처리가 가능하다. - 사실상 enum을 사용해야 하는데 이렇게 강제시키는 것이 맞을까?
    var rawValue: String { get }
    var storyBoard: UIStoryboard { get }
    func initialViewController<ViewControllerType: UIViewController>(_ type: ViewControllerType.Type) -> ViewControllerType?
    func targetViewController<ViewControllerType: UIViewController>(_ identifier: String, _ type: ViewControllerType.Type) -> ViewControllerType?
}

extension InitiatableStoryboardSource {
    private var storyBoardName: String {
        return self.rawValue
    }
    
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
