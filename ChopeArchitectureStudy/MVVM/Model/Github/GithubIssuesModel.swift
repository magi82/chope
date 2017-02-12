//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger
import SwiftyJSON

class GithubIssuesModel: IssuesModel {
    var data: ModelData
    var issues: [Issue] = []

    private let api: IssueAPI!
    private var issuesRequest: DataRequest?

    init(data: ModelData) {
        self.data = data

        api = IssueAPI(repositories: data.githubRepositories)

        NotificationCenter.default.addObserver(forName: Notification.Name.Model.addedIssues, object: nil, queue: nil) { [weak self] notification in
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
}
