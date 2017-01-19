//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol IssuesView: class {
    func set(issues: [Issue])
    func open(url: URL)
}
