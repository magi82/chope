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

    private let api: CommentAPI!

    required init(user: String, repo: String, number: Int) {
        self.user = user
        self.repo = repo
        self.number = number
        self.items = []
        api = CommentAPI(user: user, repo: repo)
    }

    func load() {
        api.comments(issueNumber: number, success: { [weak self] comments in
            self?.items = comments
            self?.postNotificationChanged()
        }, failure: { error in
            XCGLogger.error("\(error)")
        })
    }

    func create(body: String, failure: ((Error)->Void)? = nil) {
        api.create(issueNumber: number, body: body, success: { [weak self] issue in
            self?.postNotificationAdded()
        }, failure: failure)
    }
}
