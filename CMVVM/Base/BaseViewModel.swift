//
//  BaseViewModel.swift
//  CMVVM
//
//  Created by HyeonTae Kim on 2021/11/28.
//

import Foundation
import RxSwift

class BaseViewModel<CoordinatorAction>: NSObject, BaseViewModelProtocol {
    let disposeBag = DisposeBag()
    weak var coordinator: ViewModelCoordinatorConnector?
    var coordinatorAction: CoordinatorAction? {
        coordinator as? CoordinatorAction
    }
    
    init(coordinator: ViewModelCoordinatorConnector) {
        self.coordinator = coordinator
    }
    
    deinit {
        print(">> 👋🏻 free ViewModel \(String(describing: self))")
        freeSelfCoordinator()
    }
}

protocol BaseViewModelProtocol: AnyObject {
    var coordinator: ViewModelCoordinatorConnector? { get }
    func freeSelfCoordinator()
}

extension BaseViewModelProtocol  {
    func freeSelfCoordinator() {
        coordinator?.freeFromParent()
    }
}

protocol ViewModelCoordinatorConnector: AnyObject {
    func freeFromParent()
}

extension ViewModelCoordinatorConnector where Self: BaseCoordinatorProtocol {
    func freeFromParent() {
        parentCoordinator?.removeChild(self.identifier)
    }
}
