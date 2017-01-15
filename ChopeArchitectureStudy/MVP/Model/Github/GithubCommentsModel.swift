//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

class GithubCommentsModel: CommentsModel {
    var user: String
    var repo: String
    var number: Int
    var items: [Comment]

    required init(user: String, repo: String, number: Int) {
        self.user = user
        self.repo = repo
        self.number = number
        self.items = []
    }

    func load() {
        let endpoint = "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)/comments"
        XCGLogger.default.info(endpoint)
        Alamofire.request(endpoint).responseJSON { [weak self] response in
                    if let json = response.result.value as? [[String: AnyObject]] {
                        self?.items = []

                        json.forEach { issueJson in
                            self?.items.append(Comment(githubJson: issueJson))
                        }

                        self?.postNotificationChanged()
                    }
                }
    }

    func create(body: String, failure: ((Error, String)->Void)? = nil) {
        guard let token = RepositoryServicesModel().githubAccessToken else {
            assertionFailure()
            return
        }

        let endpoint = "https://api.github.com/repos/\(user)/\(repo)/issues/\(number)/comments"
        XCGLogger.default.info(endpoint)

        Alamofire.request(endpoint, method: .post, parameters: [
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
                    if let _ = response.result.value as? [String: AnyObject] {
                        self?.postNotificationAdded()
                    }
                }
    }
}
