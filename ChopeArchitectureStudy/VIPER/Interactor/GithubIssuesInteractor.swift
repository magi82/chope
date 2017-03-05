//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import CPGithub

class GithubIssuesInteractor: RepositoryIssuesInteractor {
    var model: IssuesModel! {
        didSet {
            if case .userAndRepo(_, let repo) = model.data {
                title = repo
            } else {
                title = ""
            }
        }
    }

    var title: String = ""
    var issues: [IssueCellViewData] {
        get {
            return model.issues.map {
                let username = $0.user?.login ?? ""
                return IssueCellViewData(
                        number: $0.number,
                        title: $0.title,
                        username: username,
                        userImageURL: $0.user?.avatarURL,
                        userGithubURL: $0.user?.htmlURL,
                        countOfComments: $0.comments
                )
            }
        }
        set { }
    }
    var modelData: ModelData {
        get {
            return model.data
        }
        set {

        }
    }


    init() {
        NotificationCenter.model.addObserver(self, selector: #selector(changedIssues(notification:)), name: Notification.Name.Model.changedIssues, object: nil)
    }

    deinit {
        NotificationCenter.model.removeObserver(self)
    }

    func requestFirstPageIssues() {
        model.load()
    }

    func requestNextPageIssues() {
        model.loadNext()
    }

    @objc
    func changedIssues(notification: Notification) {
        NotificationCenter.interactor.post(name: Notification.Name.Interactor.changedIssues, object: nil)
    }
}
