//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import XCGLogger
import Alamofire

class BitbucketIssueDetailModel: IssueDetailModel {
    var user: String
    var repo: String
    var number: Int

    var issue: Issue = Issue(rawJson: [:])

    required init(user: String, repo: String, number: Int = 0) {
        self.user = user
        self.repo = repo
        self.number = number
    }

    func load() {
        let issueEndpoint = "https://api.bitbucket.org/2.0/repositories/\(user)/\(repo)/issues/\(number)"
        XCGLogger.default.info(issueEndpoint)
        Alamofire.request(issueEndpoint).responseJSON { [weak self] response in
                    if let json = response.result.value as? [String: AnyObject] {
                        self?.issue = Issue(rawJson: json)

                        self?.postNotificationChanged()
                    }
                }
    }

    func create(title: String, body: String, failure: ((Error)->Void)? = nil) {

    }
}
