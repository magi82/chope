//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueDetailPresenter {
    let model: IssueDetailModel
    var view: IssueDetailView!

    init(model: IssueDetailModel) {
        self.model = model

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssueDetail), name: Notification.Name.changedIssueDetail, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func issue() {
        model.load()
    }

    @objc func onChangedIssueDetail() {
        display()
    }

    func display() {
        let issue = model.issue
        view?.set(number: issue.number)
        view?.set(title: issue.title)
        view?.set(body: issue.body)

        if let user = issue.user {
            view?.set(username: user.name)

            if let photoUrl = URL(string: user.photoUrl) {
                view?.set(userPhotoURL: photoUrl)
            }
        }
    }
}
