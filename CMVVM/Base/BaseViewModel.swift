//
//  BaseViewModel.swift
//  CMVVM
//
//  Created by HyeonTae Kim on 2021/11/28.
//

import Foundation

class BaseViewModel: BaseViewModelProtocol {
    weak var coordinator: ViewModelCoordinatorConnector?
    
    deinit {
        freeSelfCoordinator()
    }
}

protocol BaseViewModelProtocol: AnyObject {
    var coordinator: ViewModelCoordinatorConnector? { get }
    func freeSelfCoordinator()
}

extension BaseViewModelProtocol  {
    func freeSelfCoordinator() {
        coordinator?.freeSelfCoordinator()
    }
}

protocol ViewModelCoordinatorConnector: AnyObject {
    func freeSelfCoordinator()
}

extension ViewModelCoordinatorConnector where Self: BaseCoordinatorProtocol {
    func freeSelfCoordinator() {
        parentCoordinator?.removeChild(self.identifier)
    }
}
