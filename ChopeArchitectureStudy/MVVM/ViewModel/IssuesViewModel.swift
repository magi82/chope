//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

extension Issue: Item {
    
}

class IssuesViewModel: ItemsViewModel {
    let model: IssuesModel

    init(model: IssuesModel) {
        self.model = model

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues), name: .changedIssues, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: .addedComment, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    var numberOfItems: Int {
        return model.issues.count
    }

    func itemCellViewModel(atIndex index: Int) -> ItemCellViewModel {
        guard let issue = self.item(atIndex: index) as? Issue else {
            assertionFailure()
            return IssueCellViewModel(issue: Issue(rawJson: []))
        }
        return IssueCellViewModel(issue: issue)
    }

    func item(atIndex index: Int) -> Item {
        return model.issues[index]
    }

    func loadFirst() {
        model.load()
    }

    func loadNext() {
        model.loadNext()
    }

    @objc func onChangedIssues() {
        
    }

    @objc func onAddedComment() {
        loadFirst()
    }

//    func touchUserPhoto(atIndex index: Int) {
//        guard let url = model.issues[index].user?.htmlURL else { return }
//        view?.open(url: url)
//    }
//
//    override func set(view: ItemsView) {
//        guard let issuesView = view as? IssuesView else { return }
//        self.view = issuesView
//    }
//
//    override func items() -> [Issue] {
//        return model.issues
//    }
//
//    func detailPresenter(index: Int) -> IssueDetailPresenter {
//        return IssueDetailPresenter(model: model.detailModel(index: index))
//    }
//
//    func commentsPresenter(index: Int) -> CommentsPresenter {
//        return CommentsPresenter(model: model.commentsModel(index: index))
//    }
//
//    func creationPresenter() -> IssueCreationPresenter {
//        return IssueCreationPresenter(model: model.detailModel())
//    }
}
