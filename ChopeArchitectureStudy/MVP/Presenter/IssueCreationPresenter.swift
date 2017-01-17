//
// Created by Chope on 2017. 1. 13..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueCreationPresenter {
    let model: IssueDetailModel!
    var view: IssueCreationView!

    init(model: IssueDetailModel) {
        self.model = model

        NotificationCenter.default.addObserver(self, selector: #selector(onAddedIssue(_:)), name: Notification.Name.addedIssues, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func create(title: String, body: String) {
        model.create(title: title, body: body) { [weak self] (error, message) in
            self?.view.showMessage(title: "\(error)", message: message)
        }
    }

    @objc func onAddedIssue(_ notification: Notification) {
        view.completeCreation()
    }
}