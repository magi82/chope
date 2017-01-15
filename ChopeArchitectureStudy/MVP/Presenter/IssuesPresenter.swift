//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssuesPresenter {
    let model: IssuesModel
    var view: IssuesView!

    init(model: IssuesModel) {
        self.model = model

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues), name: .changedIssues, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: .addedComment, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func touchUserPhoto(atIndex index: Int) {
        guard let url = model.issues[index].user?.profileUrl else { return }
        view?.open(url: url)
    }

    func issues() {
        model.load()
    }

    @objc func onChangedIssues() {
        view?.set(issues: model.issues)
    }

    @objc func onAddedComment() {
        issues()
    }

    func display(issue: Issue, inView cellView: IssuesCellView) {
        cellView.set(number: "\(issue.number)")
        cellView.set(title: issue.title)
        cellView.set(countOfComments: issue.comments)

        guard let user = issue.user else { return }
        cellView.setUser(name: user.name, photoURL: user.photoUrl)
    }

    func detailPresenter(index: Int) -> IssueDetailPresenter {
        return IssueDetailPresenter(model: model.detailModel(index: index))
    }

    func commentsPresenter(index: Int) -> CommentsPresenter {
        return CommentsPresenter(model: model.commentsModel(index: index))
    }

    func creationPresenter() -> IssueCreationPresenter {
        return IssueCreationPresenter(model: model.detailModel())
    }
}
