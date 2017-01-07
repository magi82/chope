//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import UIKit

class UserThumbnailButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        assertionFailure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        layer.cornerRadius = bounds.midX
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
    }
}
