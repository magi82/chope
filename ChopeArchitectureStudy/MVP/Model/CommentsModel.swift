//
// Created by Chope on 2017. 1. 15..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

protocol CommentsModel: Model {
    var number: Int { get set }
    var items: [Comment] { get set }

    func load()
    func loadNext()
    func create(body: String, failure: ((Error)->Void)?)
}

extension CommentsModel {
    func postNotificationChanged() {
        NotificationCenter.default.post(name: Notification.Name.changedComments, object: nil)
    }
    func postNotificationAdded() {
        NotificationCenter.default.post(name: Notification.Name.addedComment, object: nil, userInfo: [
                "user": user,
                "repo": repo,
                "number": number
        ])
    }
}