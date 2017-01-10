//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol IssuesCellView {
    func set(title: String)
    func set(number: String)
    func set(username: String?)
    func set(userPhotoURL: URL?)
}
