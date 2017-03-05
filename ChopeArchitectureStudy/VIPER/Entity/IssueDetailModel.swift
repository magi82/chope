//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import CPGithub

class IssueDetailModel: Model {
    var data: ModelData
    var issue: Issue = Issue(rawJson: [:])
    private let api: IssueAPI!

    required init(data: ModelData) {
        self.data = data

        api = IssueAPI(repositories: data.githubRepositories)
    }

    func load() {
        guard case ModelData.userAndRepoWithNumber(_, _, let number) = data else {
            return
        }

        api.issue(number: number, success: { [weak self] issue in
            self?.issue = issue
            NotificationCenter.model.post(name: Notification.Name.Model.changedIssue, object: nil)
        }, failure: { error in
        })
    }

    func create(title: String, body: String, failure: ((Error)->Void)? = nil) {
        api.create(title: title, body: body, success: { [weak self] issue in
            self?.issue = issue
            NotificationCenter.model.post(name: Notification.Name.Model.addedIssue, object: nil)
        }, failure: { error in
            failure?(error)
        })
    }
}
