//
//  PresentableBase.swift
//  CMVVM
//
//  Created by howard on 2021/11/23.
//

import UIKit

protocol PresentableBase: AnyObject {
    func coordinate(_ type: CoordinationType)
}

extension UIViewController: PresentableBase {
    func coordinate(_ type: CoordinationType) {
        switch type {
        case .makeWindowVisible(let uiWindow, let coordinatorBase):
            guard let targetViewController = coordinatorBase.presentable as? UIViewController else {
                fatalError("ViewController Is Nil")
            }
            uiWindow.rootViewController = targetViewController
            uiWindow.makeKeyAndVisible()
        case .push(let coordinatorBase):
            guard let targetViewController = coordinatorBase.presentable as? UIViewController else {
                fatalError("ViewController Is Nil")
            }
            navigationController?.pushViewController(targetViewController, animated: true)
        case .pop:
            navigationController?.popViewController(animated: true)
        case .present(let coordinatorBase, let completion):
            guard let targetViewController = coordinatorBase.presentable as? UIViewController else {
                fatalError("ViewController Is Nil")
            }
            self.present(targetViewController, animated: true, completion: completion)
        case .dismiss(_, let completion):
            self.dismiss(animated: true, completion: completion)
        }
    }
}
