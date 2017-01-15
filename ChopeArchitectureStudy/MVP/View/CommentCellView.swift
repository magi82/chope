//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol CommentCellView {
    func set(body: String)
    func setUser(name: String, photoURL: URL?)
}
