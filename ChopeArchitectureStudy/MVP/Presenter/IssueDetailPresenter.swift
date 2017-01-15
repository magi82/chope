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
        view.reload()
    }

    func display() {
        let issue = model.issue
        view?.set(number: issue.number)
    }

    func display(view: IssueDetailCellView) {
        let issue = model.issue
        view.set(title: issue.title)
        view.set(body: issue.body)

        guard let user = issue.user else { return }
        view.setUser(name: user.name, userPhotoURL: user.photoUrl)
    }
}
