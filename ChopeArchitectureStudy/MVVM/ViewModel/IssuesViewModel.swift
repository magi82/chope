//
// Created by Chope on 2017. 1. 10..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation

extension Issue: Item {
    
}

class IssuesViewModel: ItemsViewModel {
    var data: ModelData
    let model: IssuesModel

    init(data: ModelData) {
        self.data = data
        self.model = GithubIssuesModel(data: data)

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

    @objc func onChangedIssues() {
        
    }

    @objc func onAddedComment() {
        loadFirst()
    }
}
