//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol IssueDetailModel {
    var issue: Issue { get set }

    func load()
}

extension IssueDetailModel {
    func postNotification() {
        NotificationCenter.default.post(name: Notification.Name.changedIssueDetail, object: nil)
    }
}
