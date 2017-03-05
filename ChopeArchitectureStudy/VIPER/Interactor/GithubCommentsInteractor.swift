//
// Created by Chope on 2017. 3. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class GithubCommentsInteractor: CommentsInteractor {
    var model: CommentsModel!

    var comments: [CommentCellViewData] {
        get {
            return model.items.map {
                let username = $0.user?.login ?? ""
                return CommentCellViewData(
                        body: $0.body,
                        username: username,
                        userImageURL: $0.user?.avatarURL,
                        userGithubURL: $0.user?.htmlURL
                )
            }
        }
        set { }
    }
    var modelData: ModelData {
        get {
            return model.data
        }
        set { }
    }

    init() {
        NotificationCenter.model.addObserver(self, selector: #selector(changedComments), name: Notification.Name.Model.changedComments, object: nil)
    }

    deinit {
        NotificationCenter.model.removeObserver(self)
    }

    @objc func changedComments() {
        NotificationCenter.interactor.post(name: Notification.Name.Interactor.changedComments, object: nil)
    }

    func requestFirstPageIssues() {
        model.load()
    }

    func requestNextPageIssues() {
        model.loadNext()
    }
}
