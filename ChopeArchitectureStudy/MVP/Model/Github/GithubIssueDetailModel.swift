//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

class GithubIssueDetailModel: IssueDetailModel {
    var user: String
    var repo: String
    var number: Int

    var issue: Issue = Issue(rawJson: [:])
    private let api: IssueAPI!

    required init(user: String, repo: String, number: Int = 0) {
        self.user = user
        self.repo = repo
        self.number = number

        api = IssueAPI(user: user, repo: repo)
    }

    func load() {
        api.issue(number: number, success: { [weak self] issue in
            self?.issue = issue
            self?.postNotificationChanged()
        }, failure: { error in
        })
    }

    func create(title: String, body: String, failure: ((Error)->Void)? = nil) {
        api.create(title: title, body: body, success: { [weak self] issue in
            self?.issue = issue
            self?.postNotificationAdded()
        }, failure: { error in
            failure?(error)
        })
    }
}
