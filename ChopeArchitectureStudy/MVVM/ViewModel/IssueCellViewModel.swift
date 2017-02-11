//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueCellViewModel: ItemCellViewModel {
    private var issue: Issue

    init(issue: Issue) {
        self.issue = issue
    }

    var title: String {
        return issue.title
    }

    var number: Int {
        return issue.number
    }

    var numberOfComments: Int {
        return issue.comments
    }

    var username: String? {
        return issue.user?.login
    }

    var userImageURL: URL? {
        return issue.user?.avatarURL
    }
}
