//
// Created by Chope on 2017. 3. 1..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

class IssuesPresenter: ViewDataPresenter {
    weak var view: ImplicitlyUnwrappedOptional<ViewDataView> {
        didSet {
            issuesView.set(title: interactor.title)
        }
    }
    var issuesView: IssuesView! {
        return view as! IssuesView
    }
    
    var router: IssueRouter!
    var interactor: RepositoryIssuesInteractor!

    init() {
        NotificationCenter.interactor.addObserver(self, selector: #selector(changedIssues(notification:)), name: Notification.Name.Interactor.changedIssues, object: nil)
    }

    deinit {
        NotificationCenter.interactor.removeObserver(self)
    }

    @objc
    func changedIssues(notification: Notification) {
        issuesView.set(data: interactor.issues)
    }

    func touchIssue(index: Int) {
        let viewData = interactor.issues[index]
        router.routeDetail(data: interactor.modelData, issueNumber: viewData.number)
    }

    func requestFirstPage() {
        interactor.requestFirstPageIssues()
    }

    func requestNextPage() {
        interactor.requestNextPageIssues()
    }
}