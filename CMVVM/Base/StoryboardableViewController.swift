//
//  StoryboardableViewController.swift
//  CMVVM
//
//  Created by HyeonTae Kim on 2021/11/28.
//

import UIKit

protocol StoryboardableViewController: AnyObject {
    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
    static func initialViewController<ViewControllerType: StoryboardViewModeling>(viewModel: BaseViewModelProtocol,
                                                                              _ type: ViewControllerType.Type) -> ViewControllerType
    static func targetViewController<ViewControllerType: StoryboardViewModeling>(viewModel: BaseViewModelProtocol,
                                                                             _ identifier: String,
                                                                             _ type: ViewControllerType.Type) -> ViewControllerType
}

extension StoryboardableViewController {
    static var storyboardName: String {
        String(describing: self)
    }
    
    static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardName, bundle: nil)
    }
    
    static func initialViewController<ViewControllerType: StoryboardViewModeling>(viewModel: BaseViewModelProtocol, _ type: ViewControllerType.Type) -> ViewControllerType {
        guard let initialViewController = storyboard.instantiateInitialViewController() as? ViewControllerType else {
            fatalError()
        }
        initialViewController.viewModel = viewModel
        return initialViewController
    }
    
    static func targetViewController<ViewControllerType: StoryboardViewModeling>(viewModel: BaseViewModelProtocol, _ identifier: String, _ type: ViewControllerType.Type) -> ViewControllerType {
        guard let targetViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? ViewControllerType else {
            fatalError()
        }
        targetViewController.viewModel = viewModel
        return targetViewController
    }
}
