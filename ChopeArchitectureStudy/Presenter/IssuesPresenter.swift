//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssuesPresenter {
    let model: IssuesModel!
    let view: IssuesView!

    init(model: IssuesModel, view: IssuesView) {
        self.model = model
        self.view = view

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues), name: .changedIssues, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func touchUserPhoto(atIndex index: Int) {
        guard let urlString = model.issues[index].user?.photoUrl, let url = URL(string: urlString) else {
            return
        }
        view.open(url: url)
    }

    func issues() {
        model.load()
    }

    @objc func onChangedIssues() {
        view.set(issues: model.issues)
    }

    func display(issue: Issue, inView cellView: IssuesCellView) {
        cellView.set(number: "\(issue.number)")
        cellView.set(title: issue.title)
        cellView.set(username: issue.user?.name)
        cellView.set(userPhotoURL: URL(string: issue.user?.photoUrl ?? ""))
    }
}