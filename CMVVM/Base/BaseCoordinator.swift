//
//  BaseCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/25.
//

import UIKit

class BaseCoordinator: BaseCoordinatorProtocol, StoryBoardableCoordinator, ViewModelCoordinatorConnector {
    let identifier: UUID = UUID()
    weak var parentCoordinator: BaseCoordinatorProtocol?
    var childCoordinators: [UUID : BaseCoordinatorProtocol] = [:]
    weak var presentable: PresentableBase?
    
    init(parent: BaseCoordinatorProtocol?) {
        parentCoordinator = parent
    }
}

protocol BaseCoordinatorProtocol: AnyObject {
    var identifier: UUID { get }
    var presentable: PresentableBase? { get } // weak
    var parentCoordinator: BaseCoordinatorProtocol? { get set } // weak
    var childCoordinators: [UUID: BaseCoordinatorProtocol] { get set }
    
    func coordinate(_ type: CoordinationType)
    func addChild(_ coordinator: BaseCoordinatorProtocol)
    func removeChild(_ id: UUID)
    func freeChildCoordinators()
}

extension BaseCoordinatorProtocol {
    func coordinate(_ type: CoordinationType) {
        presentable?.coordinate(type)
        switch type {
        case .makeWindowVisible(_, let coordinatorBase):
            addChild(coordinatorBase)
        case .push(let coordinatorBase):
            addChild(coordinatorBase)
        case .pop:
            break
        case .present(let coordinatorBase, _):
            addChild(coordinatorBase)
        case .dismiss:
            break
        }
    }
    
    func addChild(_ coordinator: BaseCoordinatorProtocol) {
        parentCoordinator = self
        childCoordinators.updateValue(coordinator, forKey: coordinator.identifier)
    }
    
    func removeChild(_ id: UUID) {
        childCoordinators.removeValue(forKey: id)
    }
    
    func freeChildCoordinators() {
        childCoordinators.forEach {
            $0.value.freeChildCoordinators()
        }
        childCoordinators.removeAll()
    }
}

