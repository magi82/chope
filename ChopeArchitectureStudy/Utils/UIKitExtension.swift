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
}

extension UITextView {
    func removeAllPadding() {
        textContainerInset = UIEdgeInsets()
        textContainer.lineFragmentPadding = 0
    }
}

extension CGFloat {
    var px: CGFloat {
        return self / UIScreen.main.scale
    }
}