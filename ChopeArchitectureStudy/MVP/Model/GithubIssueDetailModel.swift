//
// Created by Chope on 2017. 1. 8..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

class GithubIssueDetailModel: IssueDetailModel {
    private let user: String
    private let repo: String
    private let number: Int

    var issue: Issue = Issue()

    init(user: String, repo: String, number: Int) {
        self.user = user
        self.repo = repo
        self.number = number
    }

    func load() {
        let issueEndpoint = "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)"
        XCGLogger.default.info(issueEndpoint)
        Alamofire.request(issueEndpoint).responseJSON { response in
                    if let json = response.result.value as? [String: AnyObject] {
                        self.issue = Issue(json: json)

                        self.postNotification()
                    }
                }
    }
}
