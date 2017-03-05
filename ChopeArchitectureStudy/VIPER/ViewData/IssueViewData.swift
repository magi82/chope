//
// Created by Chope on 2017. 3. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

struct IssueViewData: ViewData {
    let number: Int
    let title: String
    let body: String
    let username: String
    let userImageURL: URL?
    let userGithubURL: URL?
}
