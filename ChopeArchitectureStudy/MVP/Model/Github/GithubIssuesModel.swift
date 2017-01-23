//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger
import SwiftyJSON

class GithubIssuesModel: IssuesModel {
    var user: String
    var repo: String
    var issues: [Issue] = []

    private let api: IssueAPI!
    private var issuesRequest: DataRequest?

    required init(user: String, repo: String) {
        self.user = user
        self.repo = repo
        api = IssueAPI(repositories: .repository(owner: user, repo: repo))

        NotificationCenter.default.addObserver(forName: Notification.Name.addedIssues, object: nil, queue: nil) { [weak self] notification in
            guard let issue = notification.userInfo?["issue"] as? Issue else { return }
            self?.issues.insert(issue, at: 0)
            self?.postNotificationChanged()
        }
    }

    func load() {
        guard issuesRequest == nil else { return }

        issuesRequest = api.issues(success: { [weak self] issues in
            self?.issues = issues
            self?.postNotificationChanged()
            self?.issuesRequest = nil
        }, failure: { [weak self] error in
            self?.issuesRequest = nil
        })
    }

    func loadNext() {
        guard issuesRequest == nil else { return }

        issuesRequest = api.loadNextPage(success: { [weak self] (issues: [Issue]) in
            self?.issues.append(contentsOf: issues)
            self?.postNotificationChanged()
            self?.issuesRequest = nil
        }, failure: { [weak self] error in
            self?.issuesRequest = nil
        })
    }

    func detailModel(index: Int) -> IssueDetailModel {
        let issue = issues[index]
        return GithubIssueDetailModel(user: user, repo: repo, number: issue.number)
    }

    func detailModel() -> IssueDetailModel {
        return GithubIssueDetailModel(user: user, repo: repo)
    }

    func commentsModel(index: Int) -> CommentsModel {
        return GithubCommentsModel(user: user, repo: repo, number: issues[index].number)
    }
}
