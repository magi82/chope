//
// Created by Chope on 2017. 1. 13..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueCreationPresenter {
    let model: IssueDetailModel!
    weak var view: IssueCreationView!

    init(model: IssueDetailModel) {
        self.model = model

        NotificationCenter.default.addObserver(self, selector: #selector(onAddedIssue(_:)), name: Notification.Name.addedIssues, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func create(title: String, body: String) {
        model.create(title: title, body: body, failure: nil)
    }

    @objc func onAddedIssue(_ notification: Notification) {
        view.completeCreation()
    }
}
