//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol IssueDetailModel {
    var user: String { get set }
    var repo: String { get set }
    var number: Int { get set }
    var issue: Issue { get set }

    init(user: String, repo: String, number: Int)

    func load()
}

extension IssueDetailModel {
    func postNotification() {
        NotificationCenter.default.post(name: Notification.Name.changedIssueDetail, object: nil)
    }
}
