//
// Created by Chope on 2017. 3. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class GithubIssueInteractor: IssueInteractor {
    var model: IssueDetailModel!

    var modelData: ModelData {
        get {
            return model.data
        }
        set { }
    }
    var issue: IssueViewData {
        get {
            let issue = model.issue
            return IssueViewData(
                    number: issue.number,
                    title: issue.title,
                    body: issue.body,
                    username: issue.user?.name ?? "",
                    userImageURL: issue.user?.avatarURL,
                    userGithubURL: issue.user?.htmlURL
            )
        }
        set { }
    }

    init() {
        NotificationCenter.model.addObserver(self, selector: #selector(changedIssue), name: Notification.Name.Model.changedIssue, object: nil)
    }

    deinit {
        NotificationCenter.model.removeObserver(self)
    }

    @objc func changedIssue() {
        NotificationCenter.interactor.post(name: Notification.Name.Interactor.changedIssue, object: nil)
    }

    func request() {
        model.load()
    }
}
