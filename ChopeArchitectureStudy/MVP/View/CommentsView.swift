//
// Created by Chope on 2017. 1. 16..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol CommentsView {
    func set(comments: [Comment])
    func showMessage(title: String?, message: String?)
}
