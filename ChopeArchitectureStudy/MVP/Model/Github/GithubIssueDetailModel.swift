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

    required init(user: String, repo: String, number: Int = 0) {
        self.user = user
        self.repo = repo
        self.number = number
    }

    func load() {
        let endpoint = "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)"
        XCGLogger.default.info(endpoint)
        Alamofire.request(endpoint).responseJSON { [weak self] response in
                    if let json = response.result.value as? [String: AnyObject] {
                        self?.issue = Issue(githubJson: json)
                        self?.postNotificationChanged()
                    }
                }
    }

    func create(title: String, body: String, failure: ((Error, String)->Void)? = nil) {
        guard let token = RepositoryServicesModel().githubAccessToken else {
            assertionFailure()
            return
        }

        let endpoint = "https://api.github.com/repos/\(user)/\(repo)/issues"
        XCGLogger.default.info(endpoint)

        Alamofire.request(endpoint, method: .post, parameters: [
                        "title": title,
                        "body": body
                ], encoding: JSONEncoding.default, headers: [
                    "Authorization": "token \(token)"
                ])
                .validate()
                .responseJSON { [weak self] response in
                    if case .failure(let error) = response.result {
                        failure?(error, "\(response)")
                        return
                    }

                    XCGLogger.default.info(response)
                    if let json = response.result.value as? [String: AnyObject] {
                        self?.issue = Issue(githubJson: json)
                        self?.postNotificationAdded()
                    }
                }
    }
}
