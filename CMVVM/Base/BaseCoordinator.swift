//
//  BaseCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/25.
//

import UIKit

class BaseCoordinator {
    // presentableTarget
    // viewmodel
    
    // vc <-> vm <-> coordinator <-> coordinator <-> coordiantor
    
    // coordinator 생성후 저장, presentable 은 띄우기만 하고 저장할 필요 x
    // coordinate를 사용하려면 presentable을 알아야 함 ? 하지만 어떤것인지 알필요 x
    
    
    
}


// Storyboard Initializer

// 화 + 15 분, 수 - 45, 목 0 , 금 + 30 ( 6시 )

enum NewCoordinationType {
    case makeWindowVisible(UIWindow, root: CoordinatorBase)
    case push(CoordinatorBase)
    case pop(CoordinatorBase)
    case present(CoordinatorBase, completion: (() -> Void)?)
    case dismiss(CoordinatorBase, completion: (() -> Void)?)
}

protocol CoordinatorBase: AnyObject {
    var identifier: UUID { get }
    var parentCoordinator: CoordinatorBase? { get } // weak
    // parent를 관찰해서 사라지는 경우 childCoordinator 를 다 없애준다. -> relay 로 전환
    // freeChildCoordinator
    var childCoordinators: [UUID: CoordinatorBase] { get set }
    var presentable: PresentableBase? { get }
    
    func setParentCoordinator(_ parent: CoordinatorBase?)
    func coordinate(_ type: NewCoordinationType)
    func addChild(_ coordinator: CoordinatorBase)
    func removeChild(_ id: UUID)
    func freeChildCoordinators()
}

extension CoordinatorBase {
    func coordinate(_ type: NewCoordinationType) {
        presentable?.coordinate(type)
        switch type {
        case .makeWindowVisible(_, let coordinatorBase): // window 전환하기 전 remove child 등의 작업이 필요
            coordinatorBase.setParentCoordinator(self)
            addChild(coordinatorBase)
        case .push(let coordinatorBase):
            addChild(coordinatorBase)
        case .pop(let coordinatorBase):
            removeChild(coordinatorBase.identifier)
        case .present(let coordinatorBase, _):
            addChild(coordinatorBase)
        case .dismiss(let coordinatorBase, _):
            removeChild(coordinatorBase.identifier)
        }
    }
    
    func addChild(_ coordinator: CoordinatorBase) {
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
