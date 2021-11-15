//
//  CoordinatorBase.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import Foundation
import UIKit

enum CoordinationType {
    case makeWindowVisible(UIWindow, root: CoordinatorBase)
    case push(CoordinatorBase)
    case pop
    case present(CoordinatorBase, completion: (() -> Void)?)
    case dismiss(completion: (() -> Void)?)
}

protocol CoordinatorBase: StoryBoardableCoordinator {
    var viewController: UIViewController? { get }
}

extension CoordinatorBase {
    func coordinate(_ type: CoordinationType) {
        switch type {
        case .makeWindowVisible(let uiWindow, let coordinatorBase):
            uiWindow.rootViewController = coordinatorBase.viewController
            uiWindow.makeKeyAndVisible()
        case .push(let coordinatorBase):
            guard let targetViewController = coordinatorBase.viewController else { return }
            viewController?.navigationController?.pushViewController(targetViewController, animated: true)
        case .pop:
            viewController?.navigationController?.popViewController(animated: true)
        case .present(let coordinatorBase, let completion):
            guard let targetViewController = coordinatorBase.viewController else { return }
            viewController?.present(targetViewController, animated: true, completion: completion)
        case .dismiss(let completion):
            viewController?.dismiss(animated: true, completion: completion)
        }
    }
}
