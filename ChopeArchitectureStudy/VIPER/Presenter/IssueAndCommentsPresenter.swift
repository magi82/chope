//
// Created by Chope on 2017. 3. 5..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssueAndCommentsPresenter: ViewDataPresenter {
    var view: ImplicitlyUnwrappedOptional<ViewDataView>
    var commentsInteractor: CommentsInteractor!
    var issueInteractor: IssueInteractor!
    var router: IssueRouter!

    private var issueAndCommentsView: IssueAndCommentsView! {
        return view as! IssueAndCommentsView
    }

    init() {
        NotificationCenter.interactor.addObserver(self, selector: #selector(changedComments), name: Notification.Name.Interactor.changedComments, object: nil)
        NotificationCenter.interactor.addObserver(self, selector: #selector(changedIssue), name: Notification.Name.Interactor.changedIssue, object: nil)
    }

    deinit {
        NotificationCenter.interactor.removeObserver(self)
    }

    @objc func changedComments() {
        view.set(data: commentsInteractor.comments)
    }

    @objc func changedIssue() {
        view.set(headerData: issueInteractor.issue)
    }

    func requestFirstPage() {
        commentsInteractor.requestFirstPageIssues()
        issueInteractor.request()
    }

    func requestNextPage() {
        commentsInteractor.requestNextPageIssues()
    }
}
