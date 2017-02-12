//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol IssueDetailModel: Model {
    var issue: Issue { get set }

    func load()
    func create(title: String, body: String, failure: ((Error)->Void)?)
}

extension IssueDetailModel {
    func postNotificationChanged() {
        NotificationCenter.default.post(name: Notification.Name.Model.changedIssueDetail, object: nil)
    }
    func postNotificationAdded() {
        NotificationCenter.default.post(name: Notification.Name.Model.addedIssues, object: nil, userInfo: [
            "issue": issue
        ])
    }
}
