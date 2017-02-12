//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol CommentsModel: Model {
    var items: [Comment] { get set }

    func load()
    func loadNext()
    func create(body: String, failure: ((Error)->Void)?)
}

extension CommentsModel {
    func postNotificationChanged() {
        NotificationCenter.default.post(name: Notification.Name.Model.changedComments, object: nil)
    }
    func postNotificationAdded() {
        guard case .userAndRepoWithNumber(let user, let repo, let number) = data else { return }

        NotificationCenter.default.post(name: Notification.Name.Model.addedComment, object: nil, userInfo: [
                "user": user,
                "repo": repo,
                "number": number
        ])
    }
}