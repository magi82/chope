//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire

let GithubIssuesChangedNotification: Notification.Name = Notification.Name("githubIssuesChanged")

class GithubIssueModel {
    private let user: String
    private let repo: String

    private(set) var issues: [GithubIssue] = []

    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }

    func load() {
        Alamofire.request("https://api.github.com/repos/\(user)/\(repo)/issues").responseJSON { response in
                    if let json = response.result.value as? [[String: AnyObject]] {
                        self.issues = []

                        json.forEach { issueJson in
                            self.issues.append(GithubIssue(json: issueJson))
                        }

                        NotificationCenter.default.post(name: GithubIssuesChangedNotification, object: self)
                    }
                }
    }
}
