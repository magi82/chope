//
// Created by Chope on 2017. 2. 12..
// Copyright (c) 2017 Chope. All rights reserved.
//

import Foundation


extension Comment: Item {

}


class CommentsWithIssueViewModel: ItemsViewModel {
    var data: ModelData

    private let issueModel: IssueDetailModel
    private let commentsModel: CommentsModel

    init(data: ModelData, issueNumber: Int) {
        self.data = data.withNumber(number: issueNumber)
        self.issueModel = GithubIssueDetailModel(data: self.data)
        self.commentsModel = GithubCommentsModel(data: self.data)

        NotificationCenter.default.addObserver(self, selector: #selector(onChangedComments), name: Notification.Name.changedComments, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAddedComment), name: Notification.Name.addedComment, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    var numberOfItems: Int {
        return commentsModel.items.count + 1
    }

    func itemCellType(atIndex index: Int) -> ItemCellType {
        return index == 0 ? .header : .item
    }

    func itemCellViewModel(atIndex index: Int) -> ItemCellViewModel {
        if index == 0 {
            let issue = issueModel.issue
            return IssueCellViewModel(issue: issue)
        }
        let comment = item(atIndex: index) as! Comment
        return CommentCellViewModel(comment: comment)
    }

    func item(atIndex index: Int) -> Item {
        return index == 0 ? issueModel.issue : commentsModel.items[index-1]
    }

    func loadFirst() {
        issueModel.load()
        commentsModel.load()
    }

    func loadNext() {
        commentsModel.loadNext()
    }

    @objc func onChangedComments() {
        loadFirst()
    }

    @objc func onAddedComment() {
        loadFirst()
    }

    func postComment(body: String) {
        commentsModel.create(body: body) { error in
        }
    }
}