//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol IssueDetailModel: Model {
    var number: Int { get set }
    var issue: Issue { get set }

    init(user: String, repo: String, number: Int)

    func load()
    func create(title: String, body: String, failure: ((Error)->Void)?)
}

extension IssueDetailModel {
    func postNotificationChanged() {
        NotificationCenter.default.post(name: Notification.Name.changedIssueDetail, object: nil)
    }
    func postNotificationAdded() {
        NotificationCenter.default.post(name: .addedIssues, object: nil, userInfo: [
            "issue": issue
        ])
    }
}
