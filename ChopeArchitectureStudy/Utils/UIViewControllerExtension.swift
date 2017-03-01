//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappingNavigationController() -> UINavigationController {
        return UINavigationController.navigationController(rootViewController: self)
    }
}

extension UINavigationController {
    class func navigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }
}