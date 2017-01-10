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

    var issue: Issue = Issue()

    required init(user: String, repo: String, number: Int) {
        self.user = user
        self.repo = repo
        self.number = number
    }

    func load() {
        let issueEndpoint = "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)"
        XCGLogger.default.info(issueEndpoint)
        Alamofire.request(issueEndpoint).responseJSON { response in
                    if let json = response.result.value as? [String: AnyObject] {
                        self.issue = Issue(githubJson: json)

                        self.postNotification()
                    }
                }
    }
}