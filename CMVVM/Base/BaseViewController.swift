//
//  BaseViewController.swift
//  CMVVM
//
//  Created by HyeonTae Kim on 2021/11/28.
//

import UIKit

typealias StoryboardViewModeling = BaseViewControllerProtocol & StoryboardableViewController

class BaseViewController: UIViewController, StoryboardViewModeling {
    weak var viewModel: BaseViewModelProtocol?
}

protocol BaseViewControllerProtocol: AnyObject {
    var viewModel: BaseViewModelProtocol? { get set }
}
