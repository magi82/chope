//
// Created by Chope on 2017. 2. 28..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

protocol NavigationRouter {
    var navigationController: UINavigationController? { set get }

    func push(viewController: UIViewController, animated: Bool)
}

protocol PresentRouter {
    var viewController: UIViewController? { set get }

    func present(viewController: UIViewController, animated: Bool, completion: (()->Void)?)
}


extension NavigationRouter {
    func push(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}

extension PresentRouter {
    func present(viewController: UIViewController, animated: Bool, completion: (()->Void)? = nil) {
        self.viewController?.present(viewController, animated: animated, completion: nil)
    }
}