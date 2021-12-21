//
//  CoordinateType.swift
//  CMVVM
//
//  Created by HyeonTae Kim on 2021/11/28.
//

import UIKit

enum CoordinationType {
    case makeWindowVisible(UIWindow, root: BaseCoordinatorProtocol)
    case push(BaseCoordinatorProtocol)
    case pop
    case present(BaseCoordinatorProtocol, completion: (() -> Void)?)
    case dismiss(completion: (() -> Void)?)
}
