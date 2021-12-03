//
//  StoryboardableCoordinator.swift
//  CMVVM
//
//  Created by howard on 2021/11/12.
//

import Foundation
import UIKit

protocol StoryBoardableCoordinator {
    func storyBoardViewController<ViewControllerType: StoryboardViewModeling>(viewModel: BaseViewModelProtocol,
                                                                              identifier: String?,
                                                                              _ type: ViewControllerType.Type) -> ViewControllerType
}

extension StoryBoardableCoordinator {
    func storyBoardViewController<ViewControllerType: StoryboardViewModeling>(viewModel: BaseViewModelProtocol,
                                                                              identifier: String? = nil,
                                                                              _ type: ViewControllerType.Type) -> ViewControllerType {
        
        if let identifier = identifier {
            return ViewControllerType.targetViewController(viewModel: viewModel, identifier, type)
        } else {
            return ViewControllerType.initialViewController(viewModel: viewModel, type)
        }
    }
}
