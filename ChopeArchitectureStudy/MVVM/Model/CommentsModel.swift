//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

class CommentsModel: Model {
    var data: ModelData
    var items: [Comment]

    private let api: CommentAPI!
    private var commentsRequest: DataRequest?

    required init(data: ModelData) {
        self.data = data
        self.items = []

        api = CommentAPI(repositories: data.githubRepositories)
    }

    func load() {
        guard commentsRequest == nil else { return }
        guard case .userAndRepoWithNumber(_, _, let number) = data else { return }

        commentsRequest = api.comments(issueNumber: number, success: { [weak self] comments in
            self?.items = comments
            XCGLogger.debug("\(self?.items.count) : \(comments.count)")
            NotificationCenter.default.post(name: Notification.Name.Model.changedComments, object: nil)
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
            NotificationCenter.default.post(name: Notification.Name.Model.changedComments, object: nil)
            self?.commentsRequest = nil
        }, failure: { [weak self] error in
            self?.commentsRequest = nil
        })
    }

    func create(body: String, failure: ((Error)->Void)? = nil) {
        guard case .userAndRepoWithNumber(_, _, let number) = data else { return }
        
        api.create(issueNumber: number, body: body, success: { issue in
            NotificationCenter.default.post(name: Notification.Name.Model.addedComment, object: nil)
        }, failure: failure)
    }
}
