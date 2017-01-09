//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

class IssuesModel {
    static let ChangedNotification: Notification.Name = Notification.Name("githubIssuesChanged")

    let user: String
    let repo: String

    private(set) var issues: [Issue] = []

    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }

    func load() {
        let issueEndpoint = "https://api.github.com/repos/\(user)/\(repo)/issues"
        XCGLogger.default.info(issueEndpoint)
        Alamofire.request(issueEndpoint).responseJSON { response in
                    if let json = response.result.value as? [[String: AnyObject]] {
                        self.issues = []

                        json.forEach { issueJson in
                            self.issues.append(Issue(json: issueJson))
                        }

                        NotificationCenter.default.post(name: type(of: self).ChangedNotification, object: self)
                    }
                }
    }
}
