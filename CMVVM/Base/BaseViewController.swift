//
//  BaseViewController.swift
//  CMVVM
//
//  Created by HyeonTae Kim on 2021/11/28.
//

import UIKit
import RxSwift

typealias StoryboardViewModeling = BaseViewControllerProtocol & StoryboardableViewController

//class BaseViewController<ViewModel: BaseViewModelProtocol>: UIViewController, StoryboardViewModeling {
//    var viewModel: ViewModel?
//}

class BaseViewController<ViewAction, ModelOutput>: UIViewController, StoryboardViewModeling {
    let disposeBag = DisposeBag()
    lazy var viewAction: ViewAction = {
        viewModel as! ViewAction
    }()
    lazy var modelOutput: ModelOutput = {
        viewModel as! ModelOutput
    }()
    var viewModel: BaseViewModelProtocol?
    
    init(_ viewModel: BaseViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print(">> 👋🏻 free ViewController \(String(describing: self))")
    }
}

protocol BaseViewControllerProtocol: AnyObject {
    var viewModel: BaseViewModelProtocol? { get set }
}
