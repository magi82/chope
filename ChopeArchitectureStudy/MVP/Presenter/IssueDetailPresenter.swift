//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueDetailPresenter {
    let model: IssueDetailModel
    weak var view: IssueDetailView!

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
        let issue = model.issue
        view?.set(issue: issue)
    }
}
