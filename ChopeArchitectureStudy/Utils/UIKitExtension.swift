//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

extension UIView {
    func adjustBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    func adjustRound(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }

    func adjustDefaultBorderStyle() {
        adjustBorder(width: CGFloat(1).px, color: UIColor.defaultBorderColor)
        adjustRound(radius: 5)
    }
}

extension UITextView {
    func removeAllPadding() {
        textContainerInset = UIEdgeInsets()
        textContainer.lineFragmentPadding = 0
    }
}

extension UIViewController {
    func addChild(viewController: UIViewController, containerView: UIView?) {
        guard let containerView = containerView ?? self.view else { return }
        addChildViewController(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", metrics: nil, views: ["view": viewController.view]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", metrics: nil, views: ["view": viewController.view]))
        viewController.didMove(toParentViewController: self)
    }
}

extension UIColor {
    static var defaultBorderColor: UIColor {
        return UIColor(white: 0.8, alpha: 1.0)
    }
}