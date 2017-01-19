//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import XCGLogger
import Alamofire
import SwiftyJSON

class BitbucketIssuesModel : IssuesModel {
    var user: String
    var repo: String
    var issues: [Issue] = []

    required init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }

    func load() {
        let issueEndpoint = "https://api.bitbucket.org/2.0/repositories/\(user)/\(repo)/issues"
        XCGLogger.default.info(issueEndpoint)
        Alamofire.request(issueEndpoint).responseJSON { response in
                    if let json = response.result.value as? [String: AnyObject], let rawIssuesJson = json["values"] as? [[String: AnyObject]] {
                        self.issues = []

                        rawIssuesJson.forEach { issueJson in
                            self.issues.append(Issue(rawJson: issueJson))
                        }

                        self.postNotificationChanged()
                    }
                }
    }

    func loadNext() {
    }

    func detailModel(index: Int) -> IssueDetailModel {
        let issue = issues[index]
        return BitbucketIssueDetailModel(user: user, repo: repo, number: issue.number)
    }

    func detailModel() -> IssueDetailModel {
        return BitbucketIssueDetailModel(user: user, repo: repo)
    }

    func commentsModel(index: Int) -> CommentsModel {
        let issue = issues[index]
        return BitbucketCommentsModel(user: user, repo: repo, number: issue.number)
    }
}
