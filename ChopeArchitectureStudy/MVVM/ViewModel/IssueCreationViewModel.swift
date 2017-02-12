//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueCreationViewModel {
    var data: ModelData
    let model: IssueDetailModel

    init(data: ModelData) {
        self.data = data
        self.model = IssueDetailModel(data: data)

        NotificationCenter.default.addObserver(self, selector: #selector(onAddedIssue), name: Notification.Name.Model.addedIssue, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func postIssue(title: String, body: String) {
        model.create(title: title, body: body) { error in
        }
    }

    @objc func onAddedIssue() {
        NotificationCenter.default.post(name: Notification.Name.ViewModel.addedIssue, object: nil)
    }
}
