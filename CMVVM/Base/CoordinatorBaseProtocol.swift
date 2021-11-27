//
//  CoordinatorBaseClass.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import Foundation
import UIKit

enum CoordinationType {
    case makeWindowVisible(UIWindow, root: CoordinatorBaseProtocol)
    case push(CoordinatorBaseProtocol)
    case pop(CoordinatorBaseProtocol)
    case present(CoordinatorBaseProtocol, completion: (() -> Void)?)
    case dismiss(CoordinatorBaseProtocol, completion: (() -> Void)?)
}

class CoordinatorBaseClass: CoordinatorBaseProtocol {
    var presentable: PresentableBase?
    var childCoordinators: [CoordinatorBaseProtocol] = []
}

class VCCoordinator<Preesntable: UIViewController>: CoordinatorBaseProtocol {
    var presentable: PresentableBase?
    var childCoordinators: [CoordinatorBaseProtocol] = []
    
    init(_ presentable: Preesntable) {
        self.presentable = presentable
    }
}

protocol CoordinatorBaseProtocol: AnyObject, StoryBoardableCoordinator {
    var identitifier: String { get }
    var presentable: PresentableBase? { get set }
    var childCoordinators: [CoordinatorBaseProtocol] { get set }
    func setPresentable(_ presentable: PresentableBase)
    func coordinate(_ type: CoordinationType)
    func addChild(_ coordinator: CoordinatorBaseProtocol)
    func removeChild(_ coordinator: CoordinatorBaseProtocol)
}

extension CoordinatorBaseProtocol {
    var identitifier: String {
        return String(describing: self)
    }
    
    func setPresentable(_ presentable: PresentableBase) {
        self.presentable = presentable
    }
    
    func coordinate(_ type: CoordinationType) {
        presentable?.coordinate(type)
        switch type {
        case .makeWindowVisible(_, let coordinatorBase):
            // remove child 등의 작업이 필요할듯
            addChild(coordinatorBase)
        case .push(let coordinatorBase):
            addChild(coordinatorBase)
        case .pop(let coordinatorBase):
            removeChild(coordinatorBase)
        case .present(let coordinatorBase, _):
            addChild(coordinatorBase)
        case .dismiss(let coordinatorBase, _):
            removeChild(coordinatorBase)
        }
    }
    
    func addChild(_ coordinator: CoordinatorBaseProtocol) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: CoordinatorBaseProtocol) {
        var targetIndex: Int?
        for (index, childCoordinator) in childCoordinators.enumerated() where childCoordinator.identitifier == coordinator.identitifier {
            targetIndex = index
            break
        }
        
        guard let targetIndex = targetIndex else { return }
        childCoordinators.remove(at: targetIndex)
    }
}
