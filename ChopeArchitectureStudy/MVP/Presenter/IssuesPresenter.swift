//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssuesPresenter: ItemsPresenter<Issue> {
    let model: IssuesModel
    weak var view: IssuesView!

    init(model: IssuesModel) {
        self.model = model

        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues), name: .changedIssues, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: .addedComment, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func touchUserPhoto(atIndex index: Int) {
        guard let url = model.issues[index].user?.htmlURL else { return }
        view?.open(url: url)
    }

    override func set(view: ItemsView) {
        guard let issuesView = view as? IssuesView else { return }
        self.view = issuesView
    }

    override func loadFirst() {
        model.load()
    }

    override func loadNext() {
        model.loadNext()
    }

    override func items() -> [Issue] {
        return model.issues
    }

    @objc func onChangedIssues() {
        view?.set(items: model.issues)
    }

    @objc func onAddedComment() {
        loadFirst()
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
