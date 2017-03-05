//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation
import CPGithub
import ChopeLibrary

extension Issue: Item {
    
}

class IssuesViewModel: GithubItemsViewModel {
    var data: ModelData
    let model: IssuesModel

    init(data: ModelData) {
        self.data = data
        self.model = IssuesModel(data: data)

        NotificationCenter.default.addObserver(self, selector: #selector(onAddedIssue), name: Notification.Name.Model.addedIssue, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangedIssues), name: Notification.Name.Model.changedIssues, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: Notification.Name.Model.addedComment, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    var title: String {
        switch data {
        case .userAndRepo(_, let repo):
            return repo
        default:
            return ""
        }
    }

    func modelData() -> ModelData {
        return self.data
    }

    var numberOfItems: Int {
        return model.issues.count
    }

    func itemCellViewModel(atIndex index: Int) -> ItemCellViewModel {
        let issue = self.item(atIndex: index) as! Issue
        return IssueCellViewModel(issue: issue)
    }

    func itemCellType(atIndex index: Int) -> ItemCellType {
        return .item
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

    @objc func onAddedIssue() {
        loadFirst()
    }

    @objc func onChangedIssues() {
        NotificationCenter.default.post(name: Notification.Name.Interactor.changedIssues, object: nil)
    }

    @objc func onAddedComment() {
        loadFirst()
    }
}
