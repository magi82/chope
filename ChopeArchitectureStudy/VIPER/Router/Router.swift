//
// Created by Chope on 2017. 2. 28..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

protocol Router {
    var navigationController: UINavigationController? { set get }
    var viewController: UIViewController? { set get }

    func push(viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, animated: Bool, completion: (()->Void)?)
}


extension Router {
    func push(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion: (()->Void)? = nil) {
        self.viewController?.present(viewController, animated: animated, completion: nil)
    }
}