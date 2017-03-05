//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

struct IssueCellViewData: ViewData {
    let number: Int
    let title: String
    let username: String
    let userImageURL: URL?
    let userGithubURL: URL?
    let countOfComments: Int
}
