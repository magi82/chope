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
    private var commentsRequest: DataRequest?

    required init(user: String, repo: String, number: Int) {
        self.user = user
        self.repo = repo
        self.number = number
        self.items = []
        api = CommentAPI(repositories: .repository(owner: user, repo: repo))
    }

    func load() {
        guard commentsRequest == nil else { return }

        commentsRequest = api.comments(issueNumber: number, success: { [weak self] comments in
            self?.items = comments
            XCGLogger.debug("\(self?.items.count) : \(comments.count)")
            self?.postNotificationChanged()
            self?.commentsRequest = nil
        }, failure: { [weak self] error in
            XCGLogger.error("\(error)")
            self?.commentsRequest = nil
        })
    }

    func loadNext() {
        guard commentsRequest == nil else { return }

        commentsRequest = api.loadNextPage(success: { [weak self] (comments: [Comment]) in
            self?.items.append(contentsOf: comments)
            self?.postNotificationChanged()
            self?.commentsRequest = nil
        }, failure: { [weak self] error in
            self?.commentsRequest = nil
        })
    }

    func create(body: String, failure: ((Error)->Void)? = nil) {
        api.create(issueNumber: number, body: body, success: { [weak self] issue in
            self?.postNotificationAdded()
        }, failure: failure)
    }
}
