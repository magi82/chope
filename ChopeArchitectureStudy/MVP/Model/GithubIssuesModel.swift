//
// Created by Chope on 2017. 1. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

class GithubIssuesModel: IssuesModel {
    let user: String
    let repo: String

    var issues: [Issue] = []

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

                        self.postNotification()
                    }
                }
    }

    func detailModel(index: Int) -> IssueDetailModel {
        let issue = issues[index]
        return GithubIssueDetailModel(user: user, repo: repo, number: issue.number)
    }
}
